import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Login/OTP.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  LogIn({Key? key}) : super(key: key);
  static var routeName = "/login";

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _phoneController = TextEditingController();
  String phoneNo = "";

  var isLoading = false;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController.text = "";
  }

  Future _sendOtp(BuildContext ctx) async {
    final isValid = _form.currentState!.validate();
    isLoading = true;
    _form.currentState!.save();
    if (isValid) {
      await Provider.of<Auth>(ctx, listen: false)
          .authenticate(phoneNo)
          .catchError((e) {
        Fluttertoast.showToast(
          msg: e,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: kprimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }).then((value) {
          Fluttertoast.showToast(
            msg: "OTP Sent Successfully !",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: kprimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.of(context).pushReplacementNamed(OtpScreen.routeName, arguments: phoneNo);
      });
    } else {
      Fluttertoast.showToast(
        msg: "Enter A Valid Number !",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                        child: Lottie.asset('assets/animation/animation5.json'),
                      ),
                      const Center(
                        child: Text(
                          "Let's Unite",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 5),
                      Form(
                        key: _form,
                        child: IntlPhoneField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value!.number.isEmpty) {
                              return 'Please Enter Valid Number!';
                            }
                            return null;
                          },
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            setState(() {
                              phoneNo = phone.completeNumber.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _sendOtp(context),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: kprimaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            textStyle: const TextStyle(
                              fontSize: 18,
                            )),
                        child: const Text('Generate OTP'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
