import 'package:flutter/material.dart';

// Colors
Color kprimaryColor = Color(0xfff1BB273);
Color ksecondaryColor = Color(0xfffE3F0E2);
Color kpostColor = Color(0xfffCFEEE1);

//  Theme Style
ThemeData aikyamTheme = ThemeData(
  iconTheme: IconThemeData(color: Color(0xfff1BB273)),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: kprimaryColor,
    secondary: ksecondaryColor,
  ),
);

//Container Decoration
BoxDecoration kfillbox10 = BoxDecoration(
  color: ksecondaryColor,
  borderRadius: BorderRadius.circular(10),
);
BoxDecoration kfillbox20 = BoxDecoration(
  color: kpostColor,
  borderRadius: BorderRadius.circular(20),
);
