import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mir_e_platform/Screens/Home_Screen/Home_Screen.dart';
import 'package:mir_e_platform/Screens/Login_Screen/login_screen.dart';
import 'package:mir_e_platform/Screens/Main_Screen/Main_Screen.dart';
import 'package:mir_e_platform/Screens/Profile_Screen/Profile_Screen.dart';
import 'package:mir_e_platform/Screens/Register_Screen/Register_Screen.dart';
import 'package:mir_e_platform/Screens/Splash_Screen/Splash_Screen.dart';
import 'package:mir_e_platform/Screens/forgetPassword_screen/forgetPassword_screen.dart';

class RouteHelper {


   static String initial='/';
   static String Main='MainRoute';
   static String Login='/loginRoute';
   static String Register='/RegisterRoute';
   static String Home='/HomeRoute';
   static String forgetPassword='/ForgetPassword';
   static String mNews='/NewsRoute';
   static String profile='/ProfileRoute';

   static Map<String,WidgetBuilder> routes() => {

     initial : (_) => SplashScreen(),
     Main : (_) => MainScreen(),
     Login : (_) => LoginScreen(),
     Register : (_) => RegisterScreen(),
     Home : (_) => HomeScreen(),
     forgetPassword : (_) => ForgetpasswordScreen(),
     profile : (_) => ProfileScreen()
   };

   }

