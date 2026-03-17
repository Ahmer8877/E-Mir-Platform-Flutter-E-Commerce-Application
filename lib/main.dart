import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mir_e_platform/Providers/auth/auth_provider.data.dart';
import 'package:mir_e_platform/utils/route_Helper.dart';
import 'package:provider/provider.dart';
import 'Providers/News_provider/News_provider.dart';
import 'firebase_options.dart';

final scaffoldMessengerKey=GlobalKey<ScaffoldMessengerState>();
final navigatorKey=GlobalKey<NavigatorState>();


void main() async{

  //Firebase initialization tools code
  WidgetsFlutterBinding.ensureInitialized();
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
      ],

      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: navigatorKey,
        routes: RouteHelper.routes(),
      ),
    );
  }
}
