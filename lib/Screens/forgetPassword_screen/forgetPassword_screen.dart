import 'package:flutter/material.dart';
import 'package:mir_e_platform/Providers/auth/auth_provider.data.dart';
import 'package:provider/provider.dart';

class ForgetpasswordScreen extends StatefulWidget {
  const ForgetpasswordScreen({super.key});

  @override
  State<ForgetpasswordScreen> createState() => _ForgetpasswordScreenState();
}

class _ForgetpasswordScreenState extends State<ForgetpasswordScreen> {

  TextEditingController Email=TextEditingController();
  GlobalKey<FormState> formkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Forget Password'),
        backgroundColor: Colors.white,
      ),

      body: ListView(
        children: [
      Column(
      children: [
      SizedBox(height: 30,),
      //icon for login screen

      Center(child: Icon(Icons.flutter_dash_outlined,size: 150,color: Colors.blue.withAlpha(250),)
      ),
      ],
    ),

          //Create the column for managed the login text
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text('Forget!',
                  style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.blue.withAlpha(190)),),
              ),

              SizedBox(height: 5,),
              //Some user information text

              Center(child: Text('Please Enter valid Email !',
                style: TextStyle(color: Colors.black.withAlpha(150)),)),
            ],
          ),

          SizedBox(height: 10),

          Form(
         key: formkey,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
              child: Column(
               children: [

                 //user info edit in container

                 Column(
                   children: [

                     SizedBox(height: 12,),

                     Consumer<MyAuthProvider>(
                       builder: (context,provider,child) {
                         return Card(
                           child: TextFormField(
                             controller:provider.emailController ,
                             decoration: InputDecoration(
                                 hintText: 'Enter the Email',
                                 border: InputBorder.none,
                                 prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),
                                 suffixIcon: InkWell(
                                     onTap: (){
                                       Email.clear();
                                     },
                                     child: Icon(Icons.close)),
                                 hintMaxLines: 1
                             ),

                             //set validation for user email code

                             validator: (value) {
                               if(value==null || value.isEmpty) {
                                 return 'Please Enter Email';
                               }
                               if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                 return 'Enter valid Email';
                               }
                               return null;
                             },
                           ),
                         );
                       }
                     ),
                   ],
                 ),
                 SizedBox(height:20 ,),

                 //create the login btn for login

                 Consumer<MyAuthProvider>(
                   builder: (context,provider,child) {
                     return provider.loading? Center(child: CircularProgressIndicator(),) : ElevatedButton(
                         onPressed: (){
                           if(formkey.currentState!.validate()) {
                             provider.forgetPassword(Email.text);
                           }
                         },
                         child: Text('Reset Now',style: TextStyle(fontWeight: FontWeight.bold),)
                     );
                   }
                 ),
               ]

               ),
         ),
          ),
        ]
        )
      );
  }
}
