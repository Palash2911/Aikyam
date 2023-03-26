import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Login/Choose.dart';
import 'package:aikyam/views/Screens/Login/Login.dart';
import 'package:aikyam/views/Screens/Ngo/NRegisterScreen.dart';
import 'package:aikyam/views/Screens/Ngo/ngoBottomBar.dart';
import 'package:aikyam/views/Screens/User/BottomNavBar.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:aikyam/views/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  static var routeName = "/otp-screen";

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final auth = FirebaseAuth.instance;
  final _otpController = TextEditingController();
  String get otp => _otpController.text;
  var isLoading = false;
  var isValid = false;
  String phoneNo = "";
  var isInit = true;
  var resendVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      phoneNo = ModalRoute.of(context)!.settings.arguments.toString();
    }
    isInit = false;
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future _sendOtp(BuildContext ctx) async {
    await Provider.of<Auth>(ctx, listen: false)
        .authenticate(phoneNo)
        .catchError((e) {
      Fluttertoast.showToast(
        msg: e,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
        gravity: ToastGravity.SNACKBAR,
      );
    }).then((value) {
      Fluttertoast.showToast(
        msg: "OTP Resent Successfully !",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: kprimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
    Future.delayed(const Duration(seconds: 10)).then((value) {
      setState(() {
        resendVisible = false;
      });
    });
  }

  Future _verifyOtp(BuildContext ctx) async {
    var authProvider = Provider.of<Auth>(ctx, listen: false);
    if (otp.length == 6) {
      isValid = await authProvider.verifyOtp(otp).catchError((e) {
        Fluttertoast.showToast(
          msg: "Something Went Wrong !",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: kprimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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
      }
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Invalid OTP. Please try again",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: kprimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Center(
              child: SizedBox(
                height: 200.0,
                child: Image.asset(
                  'assets/images/loading.gif',
                  fit: BoxFit.contain,
                ),
              ),
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
                        width: 153,
                        height: 153,
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
                        "Verification Code on $phoneNo ", //You have to do it
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
                              height: 18,
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
                        "Didn't Receive OTP?",
                        style: kTextPopR16,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: resendVisible
                                  ? null
                                  : () {
                                      _sendOtp(context);
                                      setState(() {
                                        resendVisible = true;
                                      });
                                    },
                              child: Text(
                                "Resend OTP",
                                style: kTextPopB16.copyWith(
                                    color: resendVisible
                                        ? Colors.grey
                                        : kprimaryColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            InkWell(
                              child: Text(
                                "Edit Number",
                                style:
                                    kTextPopB16.copyWith(color: kprimaryColor),
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(LogIn.routeName);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
