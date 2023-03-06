import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class introTwo extends StatelessWidget {
  const introTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          children: [
            SizedBox(
              height: 280.0,
              child: Lottie.asset('assets/animation/animation2.json'),
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur dolor sit amet, consectetur",
              style: kTextPopB16,
              textAlign: TextAlign.center,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur ",
              style: kTextPopR14,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
