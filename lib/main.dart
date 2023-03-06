import 'package:aikyam/routes.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: aikyamTheme,
      routes: approutes,
      // routes: {
      //   //?User Routes
      //   // '/': (context) => UserBottomBar(),
      //   '/': (context) => Logo(),
      //   HomeScreen.routeName: (context) => HomeScreen(),
      //   ChatScreen.routeName: (context) => ChatScreen(),
      //   ActivityScreen.routeName: (context) => ActivityScreen(),
      //   // SplashScreen.routeName: (context) => SplashScreen(),
      //   //?Ngo Routes
      //   //  '/': (context) => NgoBottomBar(),
      //   // NHomeScreen.routeName: (context) => NHomeScreen(),
      //   // NgoChatScreen.routeName: (context) => NgoChatScreen(),
      //   // NgoAddpost.routeName: (context) => NgoAddpost(),
      //   // NgoActivityScreen.routeName: (context) => NgoActivityScreen(),
      // },
    );
  }
}
