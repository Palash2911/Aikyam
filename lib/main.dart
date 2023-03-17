import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/providers/chatProvider.dart';
import 'package:aikyam/providers/ngo_provider.dart';
import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/providers/user_provider.dart';
import 'package:aikyam/routes.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => NgoProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => PostProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: aikyamTheme,
        routes: approutes,
      ),
    );
  }
}
