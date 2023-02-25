import 'package:aikyam/views/Screens/User/FavoritesScreen.dart';
import 'package:aikyam/views/Screens/User/NgoProfileScreen.dart';
import 'package:aikyam/views/Screens/User/UserProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

class appdrawer extends StatelessWidget {
  const appdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xfff1BB273),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/images/dp.jpg'),
                ),
                Text(
                  'Dip Hire',
                  style: kTextPopM16.copyWith(color: ksecondaryColor),
                ),
                Text(
                  'edit profile',
                  style: kTextPopR12.copyWith(color: ksecondaryColor),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('My Favorites'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyFavoritesScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text(' Categories'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NgoProfile(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
