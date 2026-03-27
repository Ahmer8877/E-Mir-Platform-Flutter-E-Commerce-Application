import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mir_e_platform/Providers/localNotification_provider/local_notification.dart';
import 'package:mir_e_platform/main.dart';
import 'package:mir_e_platform/utils/route_Helper.dart';
import 'package:mir_e_platform/utils/show_msg.dart';
import 'package:mir_e_platform/utils/showmsg_failure.dart';
import 'package:provider/provider.dart';

import '../profile_provider/profile_provider.dart';


class MyAuthProvider with ChangeNotifier{

  //firebase instance

  FirebaseAuth auth=FirebaseAuth.instance;

  //editer controller to use clear text

  TextEditingController emailController = TextEditingController();

  //fake loading

  bool loading=false;


  // provider.login(Email.text, Password.text);

  void login(String Email,String password) async{


    try {
      _loading(true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(email:Email.trim() , password: password.trim()

      );

      await navigatorKey.currentContext!.read<ProfileProvider>().loadUserFromPrefs();

      showMsg('Login Successful');
      Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!, RouteHelper.Main, (value) => false);
      NotificationHelper.show();

    }on FirebaseAuthException catch(e){
      showMsgFailure(e.toString());
    } catch (e) {
      showMsgFailure(e.toString());
    }finally{
      _loading(false);
    }
  }

  // provider.register(Name.text, Email.text, Password.text);

  void register(String name,String Email,String password) async{

    try {
     _loading(true);
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: Email.trim(),
        password: password.trim(),
      );

      // check uid in console
      print('UID: ${credential.user?.uid}');

      await navigatorKey.currentContext!.read<ProfileProvider>().saveUserToPrefs(
        name: name.trim(),
        email: Email.trim(),
        password: password.trim(),
      );

      showMsg('Registration Successful, login now');
      Navigator.pushReplacementNamed(navigatorKey.currentContext!, RouteHelper.Login);

    } on FirebaseAuthException catch(e){
      showMsgFailure(e.toString());
    }catch (e) {
      showMsgFailure(e.toString());
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
      showMsgFailure(e.toString());
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
    }on FirebaseAuthException catch(e){
      showMsgFailure(e.toString());
    }catch(e){
      showMsgFailure(e.toString());
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

    }on FirebaseAuthException catch(e){
      showMsgFailure(e.toString());
    }catch(e){
      showMsgFailure(e.toString());
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
