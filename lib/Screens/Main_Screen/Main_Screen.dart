import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mir_e_platform/Providers/auth/auth_provider.data.dart';
import 'package:mir_e_platform/Providers/darkTheme_provider/dark_theme.dart';
import 'package:mir_e_platform/Screens/Cart_Screen/Cart_Screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Providers/profile_provider/profile_provider.dart';
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
    CupertinoIcons.shopping_cart,

  ];

  //create the pageName list used for app bar center title

  final List<String> pageName=[
    "Home",
    "M.News",
    "Profile",
    "Cart"
  ];

  //whatsApp Link

  Uri whatsAppUri=Uri.parse('https://wa.me/qr/ECJDRCYFI53AA1');

  //mail uri

  Uri mailUri=Uri(scheme: 'mailto',path: 'rajpootahmer786@gmail.com',query: 'subject: Example Subject & Symbols are allowed!');

  //create the all widget list in app

  final List<Widget> widgets=[HomeScreen(),mNewsScreen(),ProfileScreen(),CartScreen()];

  @override
  Widget build(BuildContext context) {


    //this is the root of application and provide interface
    return Scaffold(
      backgroundColor: Colors.white,
        key: globalKey,
        //set the app bar(code)

        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Image.asset('assets/icons/Mlogo.gif',fit: BoxFit.cover),
          centerTitle: true,
          title: Text(pageName[currentIndex],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        //set the bottom navigation with smooth animation(code)

        bottomNavigationBar: Container(
          margin: EdgeInsets.all(10),
          height: 65,
          width: 65,
          child: AnimatedBottomNavigationBar(
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
        ),

        //set the drawer code

        endDrawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [

              //splash screen icon in center drawer

              Center(child: Image.asset('assets/icons/Mlogo.gif')),

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

              SizedBox(height: 20,),

              //dark theme button

              Row(
                spacing: 3,
                children: [

                  //theme icon with padding

                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(CupertinoIcons.paintbrush_fill,color: Colors.green,),
                  ),
                  //text

                  Text('Themes',style: TextStyle(fontSize: 20),),

                  //arrow text

                  Text('=>',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.deepOrange),),

                  SizedBox(width: 70,),

                  //dropDown btn

                  Consumer<ThemeProvider>(
                    builder: (context,provider,child) {
                      return DropdownButton<ThemeMode>(
                        underline: SizedBox(),
                        value: provider.themeMode,
                          onChanged: (value){
                          provider.switchTheme(value!);
                          },
                        items: [
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text('Light',style: TextStyle(fontWeight: FontWeight.bold),),
                            onTap: (){},
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text('System',style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text('Dark',style: TextStyle(fontWeight: FontWeight.bold),),
                            onTap: (){},
                          ),
                        ]
                      );
                    }
                  )
                ],
              ),

              SizedBox(height: 20,),

              //contact us in list Tile

             ListTile(
               title: Text('Contact Us'),
               leading: Image(image: AssetImage('assets/icons/whatsApp.png'),height: 30,width: 30,),
               trailing: InkWell(
                   onTap: (){
                     launchUrl(mailUri);
                   },
                   child: Image(image: AssetImage('assets/icons/mail.png'),height: 40,width: 40,)),
             ),

              //About section

              ListTile(
                title: Text('About',style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('    version 1.00v'),
              ),

              SizedBox(height: 150,),

              //logout button code with dialog box

              Consumer<MyAuthProvider>(
                builder: (context,provider,child) {
                  return TextButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text('SignOut'),
                                  content: Text('Are you sure?'),

                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          provider.logout();
                                          await context.read<ProfileProvider>().clearUserData();

                                        },
                                        child: Text('Yes')
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text('No')
                                    ),
                                  ],
                                )
                        );
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
