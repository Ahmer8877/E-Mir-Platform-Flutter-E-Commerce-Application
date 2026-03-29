import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mir_e_platform/Providers/auth/auth_provider.data.dart';
import 'package:mir_e_platform/Providers/darkTheme_provider/dark_theme.dart';
import 'package:mir_e_platform/Providers/localNotification_provider/local_notification.dart';
import 'package:mir_e_platform/Providers/profile_provider/profile_provider.dart';
import 'package:mir_e_platform/utils/route_Helper.dart';
import 'package:provider/provider.dart';
import 'Providers/News_provider/News_provider.dart';
import 'Providers/product_provider/product_provider.dart';
import 'firebase_options.dart';

//create scaffold messenger key to manage messenger in non-widgets objects

final scaffoldMessengerKey=GlobalKey<ScaffoldMessengerState>();

//create navigator key to manage context in non-widgets objects

final navigatorKey=GlobalKey<NavigatorState>();



void main() async{

  //Firebase initialization tools code
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => MyAuthProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotificationHelper()),
      ],

      child: Consumer<ThemeProvider>(
        builder: (context,provider,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: scaffoldMessengerKey,
            navigatorKey: navigatorKey,
            themeMode: provider.themeMode,
            darkTheme: ThemeData.dark(),
            routes: RouteHelper.routes(),
          );
        }
      ),
    );
  }
}
