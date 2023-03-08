import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Ngo/Choose.dart';
import 'package:aikyam/views/Screens/Ngo/NRegisterScreen.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/BottomNavBar.dart';
import 'package:aikyam/views/widgets/ngoBottomBar.dart';
import 'package:aikyam/views/widgets/otpField.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  static var routeName = "/otp-screen";

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  String get otp => _otpController.text;
  var isLoading = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future _verifyOtp(BuildContext ctx) async {
    var authProvider = Provider.of<Auth>(ctx, listen: false);
    if (otp.length == 6) {
      var isValid = await authProvider.verifyOtp(otp).catchError((e) {
        print("Failure");
      });
      if (isValid) {
        var user = await authProvider.checkUser();
        if (authProvider.isUser.toString().isEmpty) {
          Navigator.of(ctx).pushReplacementNamed(Choose.routeName);
        } else if (authProvider.isUser.toString() == "Individual") {
          if (authProvider.isProfile) {
            Navigator.of(ctx).pushReplacementNamed(UserBottomBar.routeName);
          } else {
            Navigator.of(ctx).pushReplacementNamed(UserRegister.routeName);
          }
        } else {
          if (authProvider.isProfile) {
            Navigator.of(ctx).pushReplacementNamed(NgoBottomBar.routeName);
          } else {
            Navigator.of(ctx).pushReplacementNamed(NgoRegister.routeName);
          }
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print("Failure");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print("Failure");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
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
                        "We have sent the Verification Code",
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
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: const [
                            //     textFieldOtp(first: true, last: false),
                            //     textFieldOtp(first: false, last: false),
                            //     textFieldOtp(first: false, last: false),
                            //     textFieldOtp(first: false, last: false),
                            //     textFieldOtp(first: false, last: false),
                            //     textFieldOtp(first: false, last: true),
                            //   ],
                            // ),
                            TextField(
                              controller: _otpController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'Enter OTP',
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              maxLength: 6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  _verifyOtp(context);
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ksecondaryColor),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kprimaryColor),
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
