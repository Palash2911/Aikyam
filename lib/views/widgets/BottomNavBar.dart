import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:aikyam/views/constants.dart';

import '../Screens/User/ActivityScreen.dart';
import '../Screens/User/ChatScreen.dart';
import '../Screens/User/HomeScreen.dart';



class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [HomeScreen(), ChatScreen(), ActivityScreen()];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
        icon: Icon(FeatherIcons.home),
        title: ("Home"),
        activeColorPrimary: kprimaryColor,
        inactiveColorPrimary: kprimaryColor),
    PersistentBottomNavBarItem(
      icon: Icon(FeatherIcons.messageSquare),
      title: ("Chat"),
      activeColorPrimary: kprimaryColor,
    ),
    PersistentBottomNavBarItem(
        icon: Icon(FeatherIcons.activity),
        title: ("Activity"),
        activeColorPrimary: kprimaryColor,
        inactiveColorPrimary: kprimaryColor),
  ];
}
