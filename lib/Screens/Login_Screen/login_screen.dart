import 'package:flutter/material.dart';
import 'package:mir_e_platform/Providers/auth/auth_provider.data.dart';
import 'package:mir_e_platform/utils/route_Helper.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController Email=TextEditingController();
  TextEditingController Password=TextEditingController();
  GlobalKey<FormState> formkey=GlobalKey<FormState>();
  bool isHidden=true;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
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

                      Center(
                          child: Image.asset('assets/icons/Mlogo.gif',height: 200,width: 200,)
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
                        child: Text('Login',
                          style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.blue.withAlpha(190)),),
                      ),

                      //Some user information text
                      Center(child: Text('Please Enter valid Email and Password !',
                        style: TextStyle(color: Colors.black.withAlpha(150)),)),
                    ],
                  ),

                  //create the text form field for email and password with loading

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

                                  //set validation for user email code

                                  validator: (value) {
                                    if(value==null || value.isEmpty) {
                                      return 'Please Enter Email';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              SizedBox(height: 15,),
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

                                  //set validation for user password code

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

                          //create the login btn for login

                          Consumer<MyAuthProvider>(
                            builder: (context,provider,child) {
                              return provider.loading? Center(child: CircularProgressIndicator(),):
                              ElevatedButton(
                                  onPressed: () async{
                                    if(formkey.currentState!.validate()) {

                                      provider.login(Email.text.trim(), Password.text.trim(),);
                                    }

                                  },
                                  child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold),)
                              );
                            }
                          ),

                          SizedBox(height: 0,),

                          //create the btn use for forget password in row

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(side: BorderSide.none),
                                    onPressed: (){
                                    Navigator.pushNamed(context, RouteHelper.forgetPassword);
                                    },
                                    child: Text('Forget Password!',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        fontSize: 17
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),


                          SizedBox(height: 15,),

                          //write some restrictions for users
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text('If you are new user,please.')),

                              SizedBox(width: 5,),

                              //create the register text for use register scree

                              Center(child:
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Navigator.pushNamed(context, RouteHelper.Register);
                                  });
                                },
                                child: Text('Register',
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
                    color: Colors.blue.withAlpha(150),
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
                      color: Colors.indigo.withAlpha(150),
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
                      color: Colors.pink.withAlpha(150),
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
                      color: Colors.orange.withAlpha(150),
                      shape: BoxShape.circle
                  ),
                ),
              ),

              //shirt 1
              Positioned(
                left: 240,
                top: -20,
                bottom: 600,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/Shirt1.png')))
                ),
              ),

              //shirt 2
              Positioned(
                left: -20,
                top: 100,
                bottom: 300,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/shirt2.png')))
                ),
              ),

              //shoes 1
              Positioned(
                left: 80,
                top: 100,
                bottom: 300,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/shoes1.png')))
                ),
              ),

              //shoes 2
              Positioned(
                left: 240,
                top: 250,
                bottom: 315,
                child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/shoes2.png')))
                ),
              )
            ],
          ),


    );
  }
}
