import 'package:aikyam/views/widgets/Post.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:flutter/material.dart';

class MyFavoritesScreen extends StatelessWidget {
  const MyFavoritesScreen({super.key});

  static const routeName = '/activity_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: RoundAppBar(
            title: '\t\t\t\tMy Favorites',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Post(),
              Post(),
              Post(),
              Post(),
              Post(),
            ],
          ),
        ),
      ),
    );
  }
}
