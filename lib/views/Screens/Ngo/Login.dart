import 'package:aikyam/views/Screens/Ngo/OTP.dart';
import 'package:aikyam/views/Screens/User/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);
  static var routeName = "/login";

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
                                'assets/animation/animation5.json'),
                          ),
                          Container(
                            child: Center(
                              child: Text("Login/ Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 25,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Enter Number",
                            textAlign: TextAlign.left, //not gooing  left
                          ),
                          SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              // labelText: 'Enter Phone Number',
                              hintText: 'Eg:9172xxxxx',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OTP()));
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
                            child: const Text('Generate OTP'),
                            // label: const Text('Plus One'),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: new Column(
                              children: <Widget>[
                                Text(
                                  "Have an Account?",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                FloatingActionButton.extended(
                                  elevation: 0,
                                  foregroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  shape: const StadiumBorder(
                                      side: BorderSide(
                                          color: Colors.green, width: 2)),
                                  label: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: null,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "or",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(300, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                      )),
                                  child: const Text(
                                    'Login with Google',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // label: const Text('Plus One'),
                                ),
                              ],
                            ),
                          ),
                        ])))));
  }
}
