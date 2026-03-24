import 'package:flutter/material.dart';
import 'package:mir_e_platform/main.dart';


//create once time success on msg snack bar

void showMsg(String? msg){

  scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(content: Text(msg!),
      backgroundColor: Colors.green,
  ));

}