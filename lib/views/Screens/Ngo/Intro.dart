import 'package:aikyam/views/Screens/Ngo/Login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePage extends StatefulWidget {
  @override
  _LottiePageState createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> {
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
                              Lottie.asset('assets/animation/animation2.json'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Center(
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Center(
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
                        ),
                        SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogIn()));
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
