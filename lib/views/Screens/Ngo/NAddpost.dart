import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Ngo/NCreatePostScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NRegisterScreen.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Addpost extends StatelessWidget {
  static var routeName = "/add-post";
  const Addpost({super.key});

  // void chooseUser(String user, BuildContext context) {
  //   Provider.of<Auth>(context, listen: false).chooseUserType(user);
  //   if (user == "NGO") {
  //     Navigator.of(context).pushReplacementNamed(NgoRegister.routeName);
  //   } else {
  //     Navigator.of(context).pushReplacementNamed(UserRegister.routeName);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 100),
                const Text(
                  "What do you wanna do ?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Create Post",
                        style: kTextPopB16,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NgoAddpost()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: kprimaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Image.asset(
                              'assets/images/Individual.png',
                              height: 90.0,
                              width: 90.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Flexible(
                            flex: 2,
                            child: Text(
                              "Here write something about create post option",
                              style: kTextPopR14.copyWith(color: kprimaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Post",
                        style: kTextPopB16,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NgoAddpost()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: kprimaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Image.asset(
                              'assets/images/group.png',
                              height: 90.0,
                              width: 90.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Flexible(
                            flex: 2,
                            child: Text(
                              "Here write something about Edit post option",
                              style: kTextPopR14.copyWith(color: kprimaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
