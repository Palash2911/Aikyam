import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Login/Choose.dart';
import 'package:aikyam/views/Screens/Login/Login.dart';
import 'package:aikyam/views/Screens/Ngo/NRegisterScreen.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:aikyam/views/constants.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadScreen();
  }

  Future loadScreen() async {
    var authProvider = Provider.of<Auth>(context, listen: false);
    Future.delayed(const Duration(seconds: 2), () async {
      await authProvider.autoLogin().then((_) async {
        if (authProvider.isAuth) {
          var user = await authProvider.checkUser();
          if (authProvider.isUser.isEmpty) {
            Navigator.of(context).pushReplacementNamed(Choose.routeName);
          } else if (authProvider.isUser.toString() == "Individual") {
            if (authProvider.isProfile) {
              Navigator.of(context)
                  .pushReplacementNamed(UserBottomBar.routeName);
            } else {
              Navigator.of(context)
                  .pushReplacementNamed(UserRegister.routeName);
            }
          } else {
            if (authProvider.isProfile) {
              Navigator.of(context)
                  .pushReplacementNamed(NgoBottomBar.routeName);
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
        backgroundColor: kprimaryColor,
        body: Center(
          child: SizedBox(
            height: 350.0,
            child: Image.asset(
              'assets/images/splashlogo.png',
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}
