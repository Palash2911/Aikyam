import 'package:aikyam/views/Screens/Ngo/Choose.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/otpField.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OtpScreen extends StatefulWidget {
  static var routeName = "/OtpScreen";

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 32,
                      color: kprimaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Lottie.asset('assets/animation/otp.json'),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text('Verification', style: kTextPopB24),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "We have sent the Verification Code to  +9198********",
                  style: kTextPopR14,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          textFieldOtp(first: true, last: false),
                          textFieldOtp(first: false, last: false),
                          textFieldOtp(first: false, last: false),
                          textFieldOtp(first: false, last: false),
                          textFieldOtp(first: false, last: false),
                          textFieldOtp(first: false, last: true),
                        ],
                      ),
                      
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Choose.routeName);
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                ksecondaryColor),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kprimaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text('Verify', style: kTextPopM16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Didn't you receive any code?",
                  style: kTextPopR14,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Resend New Code",
                  style: kTextPopB16.copyWith(color: kprimaryColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
