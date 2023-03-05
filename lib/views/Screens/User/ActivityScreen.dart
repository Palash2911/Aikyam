import 'package:aikyam/views/widgets/Post.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  static const routeName = '/activity_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          flexibleSpace: RoundAppBar(
            title: 'Activity',
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
