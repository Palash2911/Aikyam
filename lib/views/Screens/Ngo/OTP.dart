import 'package:aikyam/views/Screens/Ngo/Choose.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTP extends StatelessWidget {
  static String routeName = "/sign_up";

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
                            height: 280.0,
                            child: Lottie.asset(
                                'assets/animation/animation4.json'),
                          ),
                          Container(
                            child: Center(
                              child: Text("Verification Code sent",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Center(
                              child: Text("Code sent to +91 98XXXXXXX10",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  )),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter OTP',
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 25),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: new Row(
                              children: <Widget>[
                                FloatingActionButton.extended(
                                  elevation: 0,
                                  foregroundColor: Colors.green,
                                  shape: const StadiumBorder(
                                      side: BorderSide(
                                          color: Colors.green, width: 2)),
                                  label: Text("Confirm"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Choose()));
                                  },
                                ),
                                SizedBox(width: 70),
                                FloatingActionButton.extended(
                                  elevation: 0,
                                  backgroundColor: Colors.green,
                                  label: Text("Resend"),
                                  onPressed: null,
                                ),
                              ],
                            ),
                          ),
                        ])))));
  }
}
