import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Login/Login.dart';
import 'package:aikyam/views/Screens/Ngo/NActivityScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NCreatePostScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NAddpost.dart';
import 'package:aikyam/views/Screens/Ngo/NHomeScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NchatScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:aikyam/views/constants.dart';
import 'package:provider/provider.dart';

class NgoBottomBar extends StatefulWidget {
  static var routeName = '/ngo_bottom_nav';

  const NgoBottomBar({super.key});

  @override
  State<NgoBottomBar> createState() => _NgoBottomBarState();
}

class _NgoBottomBarState extends State<NgoBottomBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        hideNavigationBarWhenKeyboardShows: true,
        resizeToAvoidBottomInset: true,
        popActionScreens: PopActionScreensType.all,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const NHomeScreen(),
    const NgoChatScreen(),
    const NgoAddpost(),
    const NgoActivityScreen()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(FeatherIcons.home),
      title: ("Home"),
      activeColorPrimary: kprimaryColor,
      inactiveColorPrimary: kprimaryColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(FeatherIcons.messageSquare),
      title: ("Chat"),
      activeColorPrimary: kprimaryColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.add_box_outlined),
      title: ("Add"),
      activeColorPrimary: kprimaryColor,
    ),
    PersistentBottomNavBarItem(
        icon: const Icon(FeatherIcons.activity),
        title: ("Activity"),
        activeColorPrimary: kprimaryColor,
        inactiveColorPrimary: kprimaryColor),
  ];
}
