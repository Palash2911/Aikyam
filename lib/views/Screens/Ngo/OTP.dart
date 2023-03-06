// import 'package:aikyam/views/Screens/Ngo/Choose.dart';
// import 'package:aikyam/views/widgets/otpField.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// import 'package:aikyam/views/constants.dart';

// class OtpScreen extends StatelessWidget {
//   const OtpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     height: 210.0,
//                     child: Lottie.asset('assets/animation/otp.json'),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     "Verification Code sent",
//                     style: kTextPopB16,
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Text(
//                     "We have sent the Verification Code to +919876543210",
//                     style: kTextPopR14,
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//               OtpForm(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(color: kprimaryColor),
//                         foregroundColor: kprimaryColor,
//                         textStyle: kTextPopM16,
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         "Resend",
//                         style: kTextPopM16.copyWith(color: kprimaryColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10.0,
//                   ),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         textStyle: kTextPopM16,
//                       ),
//                       onPressed: () {},
//                       child: Text("Confirm"),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/otpField.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
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
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                child: Lottie.asset('assets/animation/otp.json'),
              ),
              SizedBox(
                height: 24,
              ),
              Text('Verification', style: kTextPopB24),
              SizedBox(
                height: 10,
              ),
              Text(
                "We have sent the Verification Code to  +9198********",
                style: kTextPopR14,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldOtp(first: true, last: false),
                        textFieldOtp(first: false, last: false),
                        textFieldOtp(first: false, last: false),
                        textFieldOtp(first: false, last: true),

                        // _textFieldOTP(first: true, last: false),
                        // _textFieldOTP(first: false, last: false),
                        // _textFieldOTP(first: false, last: false),
                        // _textFieldOTP(first: false, last: true),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(ksecondaryColor),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kprimaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text('Verify', style: kTextPopM16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: kTextPopR14,
                textAlign: TextAlign.center,
              ),
              SizedBox(
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
    );
  }
}
