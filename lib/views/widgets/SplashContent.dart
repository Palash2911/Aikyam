import 'package:flutter/material.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/SizeConfig.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "Aikyam",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kprimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        ClipOval(
          //no need to provide border radius to make circular image
          child: Image.asset(
            image!,
            height: getProportionateScreenHeight(265),
            width: getProportionateScreenWidth(235),
            fit: BoxFit.cover, //change image fill type
          ),
        )
      ],
    );
  }
}
