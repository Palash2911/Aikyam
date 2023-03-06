import 'package:aikyam/views/Screens/Login/IntroPage1.dart';
import 'package:aikyam/views/Screens/Login/IntroPage2.dart';
import 'package:aikyam/views/Screens/Login/IntroPage3.dart';
import 'package:aikyam/views/Screens/Ngo/Login.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class introScreen extends StatefulWidget {
  @override
  State<introScreen> createState() => _introScreenState();
}

class _introScreenState extends State<introScreen> {
  final _controller = PageController();

  bool _onLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // page view
          SizedBox(
            height: 500,
            child: PageView(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  _onLast = (value == 2);
                });
              },
              children: const [
                introOne(),
                introTwo(),
                introThree(),
              ],
            ),
          ),

          // dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _onLast
                  ? GestureDetector(
                      onTap: () {
                        _controller.jumpTo(1);
                      },
                      child: Text(
                        "Back",
                        style: kTextPopB16.copyWith(color: ksecondaryColor),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: Text(
                        "Skip",
                        style: kTextPopB16.copyWith(color: ksecondaryColor),
                      ),
                    ),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  activeDotColor: kpostColor,
                  dotColor: Colors.grey,
                ),
              ),
              _onLast
                  ? GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Text(
                        "Home",
                        style: kTextPopB16.copyWith(color: ksecondaryColor),
                      ))
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LogIn()));
                      },
                      child: Text(
                        "Next",
                        style: kTextPopB16.copyWith(color: ksecondaryColor),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
