import 'package:aikyam/views/widgets/AppBarHome.dart';
import 'package:aikyam/views/widgets/Post2.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: HomeAppBar(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Post(),
              Post2(),
              Post2(),
              Post2(),
              Post2(),
            ],
          ),
        ),
      ),
    );
  }
}
