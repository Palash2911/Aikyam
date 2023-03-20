import 'package:aikyam/views/widgets/activityPost.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:flutter/material.dart';

class NgoActivityScreen extends StatelessWidget {
  const NgoActivityScreen({super.key});

  static const routeName = '/ngo_activity_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: RoundAppBar(
            title: 'Activity',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ActivityPost(),
            ],
          ),
        ),
      ),
    );
  }
}
//activity screen madhe screen builder like in home screen;
//post provider made delete post karun ek functoin of type future(input parameter string);
//create instance and collection name posts doc is string id;
//createpost cha aat after 32 line ek collection reference like line 14 and 
//