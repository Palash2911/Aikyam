import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:aikyam/views/constants.dart';

class RoundAppBar extends StatelessWidget {
  const RoundAppBar({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Text(
          title,
          style: kTextPopB24.copyWith(color: ksecondaryColor),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: kprimaryColor),
    );
  }
}
