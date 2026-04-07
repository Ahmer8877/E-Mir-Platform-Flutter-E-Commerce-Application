import 'package:flutter/material.dart';
import '../main.dart';

//create once time failure msg on snack bar

void showMsgFailure(String? failure) {
  scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(content: Text(failure!),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),

  ));
}