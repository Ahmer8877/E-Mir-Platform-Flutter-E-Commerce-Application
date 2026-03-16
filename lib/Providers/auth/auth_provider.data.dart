import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mir_e_platform/main.dart';
import 'package:mir_e_platform/utils/route_Helper.dart';
import 'package:mir_e_platform/utils/show_msg.dart';

class MyAuthProvider with ChangeNotifier{
  FirebaseAuth auth=FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  bool loading=false;


  //create the func. for login user with passw and email

  void login(String email,String password) async{
    try{
      _loading(true);
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, RouteHelper.Main,(value) => false);

      showMsg('Login Successful');
    }catch(e){
      showMsg(e.toString());
    }finally{
      _loading(false);
    }
  }

  //create func. for user register accounts code

  void register(String name,String email,String password) async{
    try{
      _loading(true);
      await auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      Navigator.pushReplacementNamed(navigatorKey.currentContext!, RouteHelper.Login);
      showMsg('Registration Successful , login now');
    }catch(e){
      showMsg(e.toString());
    }finally{
      _loading(false);
    }
  }

  //create the func. for reset password for user


  void forgetPassword(String email) async{
    _loading(true);
    try{
      await auth.sendPasswordResetEmail(email: emailController.text.trim());
      emailController.clear();
      showMsg('Please check your Email');
    }catch(e){
      showMsg(e.toString());
    }finally{
      _loading(false);
    }
  }

  //create the func. for user logout with some validations and exceptions

  void logout() async{
    try{
      await auth.signOut();
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, RouteHelper.Login, (value) =>false);
      showMsg('LogOut Successful');
    }catch(e){
      showMsg(e.toString());
    }
  }

    //create func. for using google signIn for users

  void continueWithGoogle() async{

    String webClientId='1054320428779-258jk5aoe57gbrgnvhngrpearr237eb6.apps.googleusercontent.com';

    try{
      _loading(true);
      GoogleSignIn signIn=GoogleSignIn.instance;
      await signIn.initialize(serverClientId: webClientId);
      GoogleSignInAccount accounts=await signIn.authenticate();
      GoogleSignInAuthentication googleAuth=accounts.authentication;


      final credential=GoogleAuthProvider.credential(
          idToken: googleAuth.idToken
      );
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, RouteHelper.Main, (value) => false);
      showMsg('Authenticate Successful');

    }catch(e){
      showMsg(e.toString());
    }finally{
     _loading(false);
    }
  }

  //create func. for using loading

  void _loading(bool value){

    loading=value;
    notifyListeners();
  }
}
