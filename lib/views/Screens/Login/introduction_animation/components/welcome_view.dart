import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Ngo/OTP.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatefulWidget {
  final AnimationController animationController;
  const WelcomeView({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final _phoneController = TextEditingController();
  String get phoneNo => "+91${_phoneController.text}";
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController.text = "";
  }

  Future _sendOtp(BuildContext ctx) async {
    var isValid = false;
    isLoading = true;
    if (phoneNo.length == 13) {
      await Provider.of<Auth>(ctx, listen: false)
          .authenticate(phoneNo)
          .catchError((e) {
        print("Failure");
      }).then((value) => Navigator.of(context).pushNamed(OtpScreen.routeName));
    } else {
      print("Failure");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _welcomeFirstHalfAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _welcomeImageAnimation =
        Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SlideTransition(
                position: _welcomeImageAnimation,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 350, maxHeight: 350),
                  child: Lottie.asset('assets/animation/animation5.json'),
                ),
              ),
              SlideTransition(
                position: _welcomeFirstHalfAnimation,
                child: Text(
                  "Login / Sign up",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              // Padding(
              //   padding:
              //       EdgeInsets.only(left: 64, right: 64, top: 16, bottom: 16),
              //   child: Text(
              //     "Stay organised and live stress-free with you-do app",
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        textStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/google.png'),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Login with Google',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "OR",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 10.0),
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    hintText: 'Enter Your Mobile Number',
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () => _sendOtp(context),
              //   style: ElevatedButton.styleFrom(
              //       fixedSize: const Size(300, 50),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10)),
              //       backgroundColor:kprimaryColor,
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       textStyle: const TextStyle(
              //         fontSize: 18,
              //       )),
              //   child: const Text('Generate OTP'),
              // ),
              // Container(
              //   padding: const EdgeInsets.all(20),
              //   child: Column(
              //     children: <Widget>[
              //       const Text(
              //         "OR",
              //         style: TextStyle(color: Colors.grey, fontSize: 16),
              //       ),
              //       const SizedBox(height: 20),
              //       ElevatedButton(
              //         onPressed: () {},
              //         style: ElevatedButton.styleFrom(
              //             fixedSize: const Size(300, 50),
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10)),
              //             backgroundColor:
              //                 const Color.fromARGB(255, 255, 255, 255),
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 20, vertical: 10),
              //             textStyle: const TextStyle(
              //               fontSize: 18,
              //             )),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Container(
              //               height: 30.0,
              //               width: 30.0,
              //               decoration: BoxDecoration(
              //                 image: DecorationImage(
              //                     image: AssetImage('assets/images/google.png'),
              //                     fit: BoxFit.cover),
              //                 shape: BoxShape.circle,
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             Text(
              //               'Login with Google',
              //               style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ],
              //         ),
              //         // label: const Text('Plus One'),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
