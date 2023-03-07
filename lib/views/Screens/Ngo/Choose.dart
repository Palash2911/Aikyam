import 'package:aikyam/views/Screens/Ngo/RegisterScreen.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

class Choose extends StatelessWidget {

  static var routeName = "/chooseScreen";
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text(
                    "Tell us more",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Are you ?",
                    style: kTextPopR12,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "I am individual",
                        style: kTextPopB16,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(UserRegister.routeName);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: kprimaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/Individual.png',
                                height: 90.0,
                                width: 90.0,
                              )

                              // Placeholder(
                              //   fallbackHeight: 50.0,
                              //   fallbackWidth: 50.0,
                              // ),
                              ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            flex: 2,
                            child: Text(
                              "An individual who wants to contribute to various community services.",
                              style: kTextPopR14.copyWith(color: kprimaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "We are NGO",
                        style: kTextPopB16,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(NgoRegister.routeName);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: kprimaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/group.png',
                                height: 90.0,
                                width: 90.0,
                              )
                              // Placeholder(
                              //   fallbackHeight: 50.0,
                              //   fallbackWidth: 50.0,
                              // ),
                              ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            flex: 2,
                            child: Text(
                              "An established NGO looking for candidates who can contribute to our services.",
                              style: kTextPopR14.copyWith(color: kprimaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
