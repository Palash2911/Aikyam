import 'package:aikyam/views/Screens/Ngo/NActivityScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NAddPostScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NHomeScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NchatScreen.dart';
import 'package:aikyam/views/Screens/Ngo/OTP.dart';
import 'package:aikyam/views/Screens/User/ActivityScreen.dart';
import 'package:aikyam/views/Screens/User/ChatScreen.dart';
import 'package:aikyam/views/Screens/User/HomeScreen.dart';
import 'package:aikyam/views/widgets/BottomNavBar.dart';
import 'package:aikyam/views/widgets/ngoBottomBar.dart';
import 'package:flutter/material.dart';

var approutes = <String, WidgetBuilder>{
  //test screen
  '/': (context) => OtpScreen(),

  //?User Routes
  // '/': (context) => UserBottomBar(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
  ActivityScreen.routeName: (context) => ActivityScreen(),

  //?Ngo Route
  // '/': (context) => NgoBottomBar(),
  // NHomeScreen.routeName: (context) => NHomeScreen(),
  // NgoChatScreen.routeName: (context) => NgoChatScreen(),
  // NgoAddpost.routeName: (context) => NgoAddpost(),
  // NgoActivityScreen.routeName: (context) => NgoActivityScreen(),
};
