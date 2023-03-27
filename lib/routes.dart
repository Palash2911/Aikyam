import 'package:aikyam/views/Screens/Login/Choose.dart';
import 'package:aikyam/views/Screens/Login/Login.dart';
import 'package:aikyam/views/Screens/Ngo/NActivityScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NCreatePostScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NHomeScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NchatScreen.dart';
import 'package:aikyam/views/Screens/Login/OTP.dart';
import 'package:aikyam/views/Screens/Ngo/NRegisterScreen.dart';
import 'package:aikyam/views/Screens/Login/SplashScreen.dart';
import 'package:aikyam/views/Screens/Ngo/ngoBottomBar.dart';
import 'package:aikyam/views/Screens/User/BottomNavBar.dart';
import 'package:aikyam/views/Screens/User/UActivityScreen.dart';
import 'package:aikyam/views/Screens/User/ChatScreen.dart';
import 'package:aikyam/views/Screens/User/HomeScreen.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:flutter/material.dart';

var approutes = <String, WidgetBuilder>{
  //Inital Route
  '/': (context) => const SplashScreen(),

  //Login Routes
  LogIn.routeName: (context) => LogIn(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  Choose.routeName: (context) => const Choose(),

  //Registration Routes
  UserRegister.routeName: (context) => const UserRegister(),
  NgoRegister.routeName: (context) => const NgoRegister(),

  //User Routes
  UserBottomBar.routeName: (context) => const UserBottomBar(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ChatScreen.routeName: (context) => const ChatScreen(),
  ActivityScreen.routeName: (context) => const ActivityScreen(),

  //Ngo Routes
  NgoBottomBar.routeName: (context) => const NgoBottomBar(),
  NHomeScreen.routeName: (context) => const NHomeScreen(),
  NgoChatScreen.routeName: (context) => const NgoChatScreen(),
  NgoAddpost.routeName: (context) => const NgoAddpost(),
  NgoActivityScreen.routeName: (context) => const NgoActivityScreen(),
};
