import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:aikyam/views/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: kprimaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 6,
            ),
            Expanded(
              child: Container(
                decoration: kfillbox10,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "Work In Progress !",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: kprimaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                  child: TextField(
                    enabled: false,
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
            ),
          ],
        ),
      ),
    );
  }
}
