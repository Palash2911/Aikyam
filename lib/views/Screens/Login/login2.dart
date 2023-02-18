import 'package:aikyam/constants.dart';
import 'package:aikyam/widgets/fillButton.dart';
import 'package:flutter/material.dart';

class Login2 extends StatelessWidget {
  const Login2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(45.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: kText20Bold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60.0,
                  child: const TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      hintText: "Enter Phone number",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FillButton(
                    buttonText: "Generate OTP",
                    onPressed: () {
                      Navigator.pushNamed(context, "/otp");
                    }),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Don't have an account?",
                  style: kText16Regular,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kgreen),
                    foregroundColor: kgreen,
                    textStyle: kText16Regular,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/user_register");
                  },
                  child: Text(
                    "Sign Up",
                    style: kText16Regular.copyWith(color: kgreen),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "or",
                  style: kText16Regular,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  width: double.infinity,
                  height: 60.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle: kText16Regular,
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlutterLogo(
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Sign In with Google",
                          style: kText16Regular,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
