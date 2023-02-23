import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

Widget appDrawer = Drawer(
  child: ListView(
    children: <Widget>[
      DrawerHeader(
        
        decoration: const BoxDecoration(
          color: Color(0xfff1BB273),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage('assets/images/dp.jpg'),
            ),
            Text(
              'Dip Hire',
              style: kTextPopM16,
            ),
            Text(
              'edit profile',
              style: kTextPopR12,
            )
          ],
        ),
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text(' My Profile '),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.book),
        title: const Text(' My Favorites'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.category),
        title: const Text(' Categories'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('LogOut'),
        onTap: () {},
      ),
    ],
  ),
);
