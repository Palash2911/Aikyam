import 'package:aikyam/constants.dart';
import 'package:aikyam/login/otp_field.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "Verification Code sent",
                    style: kText20Bold,
                  ),
                  Text(
                    "We have sent the Verification Code to +919876543210",
                    style: kText16Regular,
                  ),
                ],
              ),
            ),
            OtpForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: kgreen),
                      foregroundColor: kgreen,
                      textStyle: kText16Regular,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Resend",
                      style: kText16Regular.copyWith(color: kgreen),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      textStyle: kText16Regular,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/user_home");
                    },
                    child: Text("Confirm"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
