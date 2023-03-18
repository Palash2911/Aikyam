import 'package:aikyam/providers/user_provider.dart';
import 'package:aikyam/views/widgets/AppBarHome.dart';
import 'package:aikyam/views/widgets/AppDrawer.dart';
import 'package:aikyam/views/widgets/Post.dart';
import 'package:aikyam/views/widgets/Post2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<UserProvider>(context)
        .getUserDetails("j2Bygr472mY7y2BJ5hAOHgd2q2o1");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: HomeAppBar(),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage('assets/images/dp.jpg'),
            ),
          ),
        ),
        drawer: const UserAppdrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              PostItem(
                ngoname: '',
                drivecity: '',
                driveDate: '',
                ngocity: '',
                driveaddress: '',
                applyStatus: '',
                pid: '',
              ),
              PostItem(
                ngoname: '',
                drivecity: '',
                driveDate: '',
                ngocity: '',
                driveaddress: '',
                applyStatus: '',
                pid: '',
              ),
              PostItem(
                ngoname: '',
                drivecity: '',
                driveDate: '',
                ngocity: '',
                driveaddress: '',
                applyStatus: '',
                pid: '',
              ),
              PostItem(
                ngoname: '',
                drivecity: '',
                driveDate: '',
                ngocity: '',
                driveaddress: '',
                applyStatus: '',
                pid: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
