import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Ngo/NRegisterScreen.dart';
import 'package:aikyam/views/Screens/User/UserRegister.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Choose extends StatefulWidget {
  static var routeName = "/chooseScreen";
  const Choose({super.key});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  var selectType = "None";
  var isBtnVisible = false;

  void chooseUser() {
    Provider.of<Auth>(context, listen: false).chooseUserType(selectType);
    if (selectType == "NGO") {
      Navigator.of(context).pushNamed(NgoRegister.routeName);
    } else if (selectType == "User") {
      Navigator.of(context).pushNamed(UserRegister.routeName);
    } else {
      Fluttertoast.showToast(
        msg: "Please Choose A Type !",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
                Text(
                  "Tell us more",
                  style: kTextPopB16.merge(TextStyle(fontSize: 21)),
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
                        "I am a Volunteer",
                        style: kTextPopB16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectType = "Individual";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: selectType == "Individual"
                            ? Border.all(width: 4, color: kprimaryColor)
                            : Border.all(width: 2, color: kprimaryColor),
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
                              "An Individual Who Intends To Contribute To Various Community Services",
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
                  const SizedBox(height: 9),
                  GestureDetector(
                    onTap: () {
                      // chooseUser("NGO", context);
                      setState(() {
                        selectType = "NGO";
                        isBtnVisible = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: selectType == "NGO"
                            ? Border.all(width: 4, color: kprimaryColor)
                            : Border.all(width: 2, color: kprimaryColor),
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
                              "An Established NGO Seeking Volunteers Who Can Contribute To Society",
                              style: kTextPopR14.copyWith(color: kprimaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        !isBtnVisible
                            ? const Text("")
                            : FloatingActionButton(
                                onPressed: chooseUser,
                                child: const Icon(Icons.arrow_forward_ios,
                                    color: Colors.green, size: 35),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
