import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mir_e_platform/utils/route_Helper.dart';
import 'dart:async';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //initialize firebase instance
  final FirebaseAuth Auth=FirebaseAuth.instance;

  //create the func. for splash screen with some validations
  void nextScreen()async{

    await Future.delayed(Duration(seconds: 3));

    if(Auth.currentUser==null){
      Navigator.pushReplacementNamed(context, RouteHelper.Login);
    }else{
      Navigator.pushReplacementNamed(context, RouteHelper.Main);

    }
  }

  //initializer for run the first screen if user application open
  @override
  void initState(){
    nextScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
        body: Center(
            child:
            //manged widgets with stack
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //Random splash screen icon with center
                    Center(child: Image.asset('assets/icons/Mlogo.gif'),),

                  ],
                ),

                //Create name with end screen

                Column(
                  children: [
                    Spacer(),
                    Center(child: const Text('Create by mir_@dev',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: CupertinoColors.inactiveGray),
                    )
                    ),
                    SizedBox(height: 15,)
                  ],
                )
              ],
            )
        )
    );
  }
}

