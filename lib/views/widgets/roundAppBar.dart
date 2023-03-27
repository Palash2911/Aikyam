import 'package:flutter/material.dart';
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
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: kprimaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Text(
          title,
          style: kTextPopB24.copyWith(color: ksecondaryColor),
        ),
      ),
    );
  }
}
