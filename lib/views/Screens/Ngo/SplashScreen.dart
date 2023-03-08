import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Ngo/Choose.dart';
import 'package:aikyam/views/Screens/Ngo/Login.dart';
import 'package:aikyam/views/Screens/Ngo/NRegisterScreen.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:aikyam/views/widgets/BottomNavBar.dart';
import 'package:aikyam/views/widgets/ngoBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:aikyam/views/widgets/SizeConfig.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static var routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadScreen();
  }

  Future loadScreen() async {
    var authProvider = Provider.of<Auth>(context, listen: false);
    Future.delayed(const Duration(seconds: 2), () async{
      await authProvider.autoLogin().then((_) {
        if (authProvider.isAuth) {
          print(authProvider.isUser);
          if (authProvider.isUser.toString().isEmpty) {
            Navigator.of(context).pushReplacementNamed(Choose.routeName);
          } else if (authProvider.isUser.toString() == "Individual") {
            if (authProvider.isProfile) {
              Navigator.of(context).pushReplacementNamed(UserBottomBar.routeName);
            } else {
              Navigator.of(context).pushReplacementNamed(UserRegister.routeName);
            }
          } else {
            if (authProvider.isProfile) {
              Navigator.of(context).pushReplacementNamed(NgoBottomBar.routeName);
            } else {
              Navigator.of(context).pushReplacementNamed(NgoRegister.routeName);
            }
          }
        } else {
          Navigator.of(context).pushReplacementNamed(LogIn.routeName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 35.0, vertical: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                SizedBox(
                  height: 380.0,
                  child: Lottie.asset('assets/animation/animation2.json'),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    "Lorem ipsum dolor sit amet, et massing elit. consectetur ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "adipiscing elit. Ut et massing elit. Ut et massi.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 19,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
