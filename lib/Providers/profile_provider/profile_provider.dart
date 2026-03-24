import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/profileData_model.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? _userModel;
  bool _isLoading = false;

  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;

  //user unique id with _key
  String _key(String field) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    return '${uid}_$field';
  }

  // register user save data

  Future<void> saveUserToPrefs({
    required String name,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final googlePhoto =
        FirebaseAuth.instance.currentUser?.photoURL ?? '';

    await prefs.setString(_key('name'), name);
    await prefs.setString(_key('email'), email);
    await prefs.setString(_key('password'), password);
    await prefs.setString(_key('photoUrl'), googlePhoto);
    await prefs.setString(
        _key('createdAt'), DateTime.now().toString().substring(0, 10));

    _userModel = UserModel(
      name: name,
      email: email,
      password: password,
      photoUrl: googlePhoto,
      createdAt: DateTime.now().toString().substring(0, 10),
    );

    notifyListeners();
  }

  // after user login load data from prefs
  Future<void> loadUserFromPrefs() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    _userModel = UserModel(
      name: prefs.getString(_key('name')) ?? '',
      email: prefs.getString(_key('email')) ?? '',
      password: prefs.getString(_key('password')) ?? '',
      photoUrl: prefs.getString(_key('photoUrl')) ?? '',
      createdAt: prefs.getString(_key('createdAt')) ?? '',
    );

    _isLoading = false;
    notifyListeners();
  }

  // photo picker rom gallery

  Future<void> pickPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile == null) return;

    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_key('photoUrl'), pickedFile.path);

    _userModel = UserModel(
      name: _userModel?.name ?? '',
      email: _userModel?.email ?? '',
      password: _userModel?.password ?? '',
      photoUrl: pickedFile.path,
      createdAt: _userModel?.createdAt ?? '',
    );

    _isLoading = false;
    notifyListeners();
  }


  //after user logout clear data

  Future<void> clearUserData() async {
    _userModel = null;
    notifyListeners();
  }
}