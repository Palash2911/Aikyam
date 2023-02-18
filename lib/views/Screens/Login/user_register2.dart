import 'package:aikyam/constants.dart';
import 'package:aikyam/widgets/fillButton.dart';
import 'package:aikyam/widgets/textTextField.dart';
import 'package:flutter/material.dart';

class UserRegister2 extends StatefulWidget {
  const UserRegister2({super.key});

  @override
  State<UserRegister2> createState() => _UserRegister2State();
}

class _UserRegister2State extends State<UserRegister2> {
  var _selectedIntrest;

  @override
  Widget build(BuildContext context) {
    var selectedGender;
    var selectedIndex = -1;
    int _choiceIndex;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30.0,
              ),
              //profile picture
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.png"),
                      radius: 60,
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                        color: Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 4),
                            color: Colors.black.withOpacity(
                              0.3,
                            ),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              // name
              // Container(
              //   width: double.infinity,
              //   height: 60.0,
              //   child: const TextField(
              //     keyboardType: TextInputType.name,
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(
              //         Icons.account_circle,
              //         color: Colors.green,
              //       ),
              //       hintText: "Enter name",
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             width: 2,
              //             color: Colors.green,
              //             style: BorderStyle.solid),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             width: 2,
              //             color: Colors.green,
              //             style: BorderStyle.solid),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10.0,
              // ),
              KTextField(labelText: 'Name', hintText: "Dip Hire"),
              KTextField(labelText: 'Contact no', hintText: "+91 9876543210"),
              KTextField(labelText: 'Email-id', hintText: "diphire@gmail.com"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: kText16Bold,
                  ),
                
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Chip(
                    label: Text(
                      'male',
                      style: kText12Regular,
                    ),
                  ),
                  Chip(label: Text('female', style: kText12Regular)),
                  Chip(label: Text('other', style: kText12Regular)),
                ],
              ),
              KTextField(labelText: 'Occupation', hintText: "Student"),
              KTextField(labelText: 'Interest', hintText: "environment"),
              //save
              FillButton(
                  buttonText: "Register",
                  onPressed: () {
                    Navigator.pushNamed(context, "/user_home");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
