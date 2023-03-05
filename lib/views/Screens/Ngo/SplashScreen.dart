import 'package:flutter/material.dart';
import 'package:aikyam/views/Screens/Ngo/Intro.dart';
import 'package:aikyam/views/widgets/SizeConfig.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: LottiePage(),
    );
  }
}
