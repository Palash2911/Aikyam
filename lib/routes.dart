import 'package:aikyam/views/Screens/Ngo/Choose.dart';
import 'package:aikyam/views/Screens/Ngo/Login.dart';
import 'package:aikyam/views/Screens/Ngo/NActivityScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NAddPostScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NHomeScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NchatScreen.dart';
import 'package:aikyam/views/Screens/Ngo/OTP.dart';
import 'package:aikyam/views/Screens/Ngo/RegisterScreen.dart';
import 'package:aikyam/views/Screens/Ngo/SplashScreen.dart';
import 'package:aikyam/views/Screens/User/ActivityScreen.dart';
import 'package:aikyam/views/Screens/User/ChatScreen.dart';
import 'package:aikyam/views/Screens/User/HomeScreen.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:aikyam/views/widgets/BottomNavBar.dart';
import 'package:aikyam/views/widgets/ngoBottomBar.dart';
import 'package:flutter/material.dart';

var approutes = <String, WidgetBuilder>{
  //Inital Route
  '/': (context) => SplashScreen(),

  //Login Routes
  LogIn.routeName: (context) => LogIn(),
  OtpScreen.routeName: (context) => OtpScreen(),
  Choose.routeName: (context) => Choose(),

  //Registration Routes
  UserRegister.routeName: (context) => UserRegister(),
  NgoRegister.routeName: (context) => NgoRegister(),

  //User Routes
  UserBottomBar.routeName: (context) => UserBottomBar(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
  ActivityScreen.routeName: (context) => ActivityScreen(),

  //Ngo Routes
  NgoBottomBar.routeName: (context) => NgoBottomBar(),
  NHomeScreen.routeName: (context) => NHomeScreen(),
  NgoChatScreen.routeName: (context) => NgoChatScreen(),
  NgoAddpost.routeName: (context) => NgoAddpost(),
  NgoActivityScreen.routeName: (context) => NgoActivityScreen(),
};
