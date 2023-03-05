import 'package:aikyam/views/Screens/User/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/Screens/Ngo/Intro.dart';
import 'package:aikyam/views/widgets/SplashContent.dart';
import 'package:aikyam/views/widgets/SizeConfig.dart';
import 'package:aikyam/views/widgets/DefaultButton.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  @override
  _LottiePageState createState() => _LottiePageState();
}

class _LottiePageState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 35.0, vertical: 45.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 380.0,
                          child:
                              Lottie.asset('assets/animation/animation1.json'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "Aikyam ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LottiePage()));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(300, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                fontSize: 18,
                              )),
                          child: const Text('Get Started'),
                          // label: const Text('Plus One'),
                        ),
                      ])))),
    );
  }
}
