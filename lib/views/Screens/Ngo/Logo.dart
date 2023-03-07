import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
            padding:
                const EdgeInsets.symmetric(horizontal: 35.0, vertical: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                SizedBox(
                  height: 380.0,
                  child: Lottie.asset('assets/animation/animation1.json'),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
