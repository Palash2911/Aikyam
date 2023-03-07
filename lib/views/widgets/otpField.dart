import 'package:aikyam/views/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class textFieldOtp extends StatelessWidget {
  const textFieldOtp({required this.first, required this.last});

  final first;
  final last;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 40,
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 0 && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: kTextPopM16,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counter: Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: kprimaryColor),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:aikyam/views/constants.dart';

// class OtpForm extends StatelessWidget {
//   const OtpForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             height: 68,
//             width: 40,
//             child: TextField(
//               onChanged: (value) {
//                 if (value == 1) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               style: kTextPopM16,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 68,
//             width: 40,
//             child: TextFormField(
//               onChanged: (value) {
//                 if (value == 1) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               style: kTextPopM16,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 68,
//             width: 40,
//             child: TextFormField(
//               decoration: InputDecoration(fillColor: kprimaryColor),
//               onChanged: (value) {
//                 if (value == 1) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               style: kTextPopM16,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 68,
//             width: 40,
//             child: TextFormField(
//               onChanged: (value) {
//                 if (value == 1) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               style: kTextPopM16,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 68,
//             width: 40,
//             child: TextFormField(
//               style: kTextPopM16,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 68,
//             width: 40,
//             child: TextField(
//               style: kTextPopM16,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
