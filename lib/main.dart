import 'package:aikyam/routes.dart';
import 'package:aikyam/views/Screens/Ngo/Login.dart';
import 'package:aikyam/views/Screens/Ngo/NActivityScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NAddPostScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NHomeScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NchatScreen.dart';
import 'package:aikyam/views/Screens/Ngo/OTP.dart';
import 'package:aikyam/views/Screens/Ngo/SplashScreen.dart';
import 'package:aikyam/views/Screens/Ngo/Intro.dart';
import 'package:aikyam/views/Screens/User/ActivityScreen.dart';
import 'package:aikyam/views/Screens/User/ChatScreen.dart';
import 'package:aikyam/views/Screens/User/HomeScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/BottomNavBar.dart';
import 'package:aikyam/views/widgets/ngoBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:aikyam/views/Screens/Ngo/Logo.dart';

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
