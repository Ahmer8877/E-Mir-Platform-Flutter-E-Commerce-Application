import 'package:flutter/material.dart';
import 'package:mir_e_platform/Providers/auth/auth_provider.data.dart';
import 'package:mir_e_platform/utils/route_Helper.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController Email=TextEditingController();
  TextEditingController Name=TextEditingController();
  TextEditingController Password=TextEditingController();
  GlobalKey<FormState> formkey=GlobalKey<FormState>();
  bool isloading=false;
  bool isHidden=true;



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.white,
        body:
        Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: 30,),
                    //icon for login screen

                    Center(child: Image.asset('assets/icons/Mlogo.gif',height: 200,width: 200,))
                  ],
                ),

                //Create the column for managed the register text
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text('Register',
                        style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.blue.withAlpha(190)),),
                    ),

                    //Some user information text
                    Center(child: Text('Please Enter valid details !',
                      style: TextStyle(color: Colors.black.withAlpha(150)),)),
                  ],
                ),

                SizedBox(height: 30,),
                //create the text form field for email and password

                Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        //user details in colum

                        Column(
                          children: [

                            SizedBox(height: 22,),

                            //Username
                            Card(
                              child: TextFormField(
                                controller: Name,
                                decoration: InputDecoration(
                                    hintText: 'Enter the User Name',
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.person,color: Colors.black,),
                                    suffixIcon: InkWell(
                                        onTap: (){
                                          Name.clear();
                                        },
                                        child: Icon(Icons.close)),
                                    hintMaxLines: 1
                                ),
                                validator: (value) {
                                  if(value==null || value.isEmpty) {
                                    return 'Please Enter User Name';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            SizedBox(height: 15,),

                            //Email
                            Card(
                              child: TextFormField(
                                controller: Email,
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
                                validator: (value) {
                                  if(value==null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            SizedBox(height: 15,),

                            //password
                            Card(
                              child: TextFormField(
                                obscureText: isHidden,
                                controller: Password,
                                decoration: InputDecoration(
                                    hintText: 'Enter the Password',
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock,color: Colors.black,),
                                    suffixIcon: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            isHidden=! isHidden;
                                          });
                                        },
                                        icon: Icon(
                                          isHidden ? Icons.visibility_off : Icons.visibility,
                                        )
                                    ),
                                    hintMaxLines: 1
                                ),
                                validator: (value) {
                                  if(value==null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height:25 ,),

                        //create the register btn for login

                        Consumer<MyAuthProvider>(
                          builder: (context,provider,child) {
                            return provider.loading? Center(child: CircularProgressIndicator(),) :
                            ElevatedButton(
                                onPressed: ()async {
                                  if(formkey.currentState!.validate()) {

                                    provider.register(Name.text.trim(), Email.text.trim(), Password.text.trim());
                                  }

                                },
                                child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold),)
                            );
                          }
                        ),

                        SizedBox(height: 5,),

                        //continue with google btn code and wrap with consumer

                        Consumer<MyAuthProvider>(
                          builder: (context,provider,child) {
                            return provider.loading? Center(child: CircularProgressIndicator(),) : ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),

                                onPressed: (){
                                  provider.continueWithGoogle();
                                },

                                label: Text('Continue With Google',
                                  style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                icon: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage('assets/icons/google.png')
                                    ),
                                  ),
                                )
                            );
                          }
                        ),

                        SizedBox(height: 5,),

                        //write some restrictions for users
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text('If you are already exist,please.')),

                            SizedBox(width: 5,),

                            //create the register text for use register scree

                            Center(child:
                            InkWell(
                              onTap: (){
                                setState(() {
                                  Navigator.pushNamed(context, RouteHelper.Login);
                                });
                              },
                              child: Text('Login',
                                style: TextStyle(color: Colors.blue.withAlpha(250),fontWeight: FontWeight.bold,fontSize: 15),),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

            //create some colorful container for using the designing

            //design 01
            Positioned(
              left: -70,
              top: -50,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.orange.withAlpha(120),
                    shape: BoxShape.circle
                ),
              ),
            ),

            //design 02
            Positioned(
              left: -100,
              top: -50,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.indigo.withAlpha(100),
                    shape: BoxShape.circle
                ),
              ),
            ),

            //disign 03
            Positioned(
              left: -45,
              top: 0,
              bottom: -850,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.green.withAlpha(100),
                    shape: BoxShape.circle
                ),
              ),
            ),

            //disign 04
            Positioned(
              left: -90,
              top: -50,
              bottom: -850,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.cyanAccent.withAlpha(150),
                    shape: BoxShape.circle
                ),
              ),
            ),
          ],
        ),


      );
  }
}
