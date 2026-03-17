import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mir_e_platform/Providers/auth/auth_provider.data.dart';
import 'package:provider/provider.dart';
import '../Home_Screen/Home_Screen.dart';
import '../Profile_Screen/Profile_Screen.dart';
import '../mNews_Screen/mNews_Screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  //create int index for screen management

  int currentIndex=0;

  //Create the global key for management for drawer current state

  GlobalKey<ScaffoldState> globalKey=GlobalKey<ScaffoldState>();

  //create the iconlist used for bottom navigation

  final iconlist=<IconData>[
    CupertinoIcons.home,
    CupertinoIcons.news,
    CupertinoIcons.profile_circled,

  ];

  //create the pageName list used for app bar center title

  final List<String> pageName=[
    "Home",
    "M.News",
    "Profile",
  ];

  //create the all widget list in app

  final List<Widget> widgets=[HomeScreen(),mNewsScreen(),ProfileScreen(),];

  @override
  Widget build(BuildContext context) {


    //this is the root of application and provide interface
    return Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,

        //set the app bar(code)

        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Icon(Icons.flutter_dash_outlined,color: Colors.blue.withAlpha(250),size: 45,),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(pageName[currentIndex],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        //set the bottom navigation with smooth animation(code)

        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconlist,iconSize: 30,
          activeIndex: currentIndex,
          notchSmoothness: NotchSmoothness.smoothEdge,
          activeColor: Colors.black,
          inactiveColor: Colors.orange.withAlpha(250),
          gapLocation: GapLocation.none,
          onTap: (value){
            setState(() {
              currentIndex=value;
            });
          },
        ),

        //set the drawer code

        endDrawer: Drawer(
          child: ListView(
            children: [

              //splash screen icon in center drawer

              Center(child: Icon(Icons.flutter_dash_outlined,size: 150,color: Colors.blue.withAlpha(250),)),

              SizedBox(height: 15,),

              //List tile for home
              ListTile(
                selected: currentIndex ==0,
                selectedColor: Colors.orange.withAlpha(250),
                title: Text('Home',style: TextStyle(fontSize: 20),),
                subtitle: Icon(CupertinoIcons.home,size: 30,),
                onTap:(){
                  globalKey.currentState?.closeEndDrawer();
                  setState(() {
                    currentIndex=0;
                  });
                },
              ),



              //List tile for M.News

              ListTile(
                selected:currentIndex ==1,
                selectedColor: Colors.orange.withAlpha(250),
                title: Text('M.News',style: TextStyle(fontSize: 20),),
                subtitle: Icon(CupertinoIcons.news,size: 30),
                onTap:(){
                  globalKey.currentState?.closeEndDrawer();
                  setState(() {
                    currentIndex=1;
                  },
                  );
                },
              ),

              //List tile for profile

              ListTile(
                selected: currentIndex ==2,
                selectedColor: Colors.orange.withAlpha(250),
                title: Text('Profile',style: TextStyle(fontSize: 20),),
                subtitle: Icon(CupertinoIcons.profile_circled,size: 30),
                onTap:(){
                  globalKey.currentState?.closeEndDrawer();
                  setState(() {
                    currentIndex=2;
                  });
                },
              ),

              SizedBox(height: 400,),

              //logout button code

              Consumer<MyAuthProvider>(
                builder: (context,provider,child) {
                  return ElevatedButton.icon(
                      onPressed: (){
                        provider.logout();
                      },
                      label: Text('LogOut'),
                      icon: Icon(Icons.login)
                  );
                }
              )
            ],
          ),
        ),

        body:
        widgets[currentIndex]
    );
  }
}
