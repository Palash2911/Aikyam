import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

class Choose extends StatelessWidget {
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  "Tell us more",
                  style: kTextPopB16,
                ),
                Text(
                  "Are you ?",
                  style: kTextPopR12,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
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
                    Navigator.pushNamed(context, '/user_register');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: kprimaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Placeholder(
                            fallbackHeight: 50.0,
                            fallbackWidth: 50.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            "An individual who wants to contribute to various community services .adipiscing elit. Ut et massing elit. Ut et massi.",
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
            margin: EdgeInsets.all(40.0),
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
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: kprimaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Placeholder(
                            fallbackHeight: 50.0,
                            fallbackWidth: 50.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
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
    );
  }
}
