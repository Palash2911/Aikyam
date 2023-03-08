import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Ngo/NRegisterScreen.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Choose extends StatelessWidget {
  static var routeName = "/chooseScreen";
  const Choose({super.key});

  void chooseUser(String user, BuildContext context) {
    Provider.of<Auth>(context, listen: false).chooseUserType(user);
    if (user == "NGO") {
      Navigator.of(context).pushReplacementNamed(NgoRegister.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(UserRegister.routeName);
    }
  }

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
                  "Tell us more",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Are you ?",
                  style: kTextPopR12,
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
                        "I am individual",
                        style: kTextPopB16,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      chooseUser("Individual", context);
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
                              "An individual who wants to contribute to various community services.",
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
                        "We are NGO",
                        style: kTextPopB16,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      chooseUser("NGO", context);
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
                              "An established NGO looking for candidates who can contribute to our services.",
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
