import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:aikyam/views/constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 75.0,
            ),
            Expanded(
              child: Container(
                decoration: kfillbox10,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    focusColor: ksecondaryColor,
                    hintText: 'Search',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: Icon(
                      FeatherIcons.search,
                      color: kprimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
