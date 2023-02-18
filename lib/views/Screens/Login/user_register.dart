import 'package:aikyam/constants.dart';
import 'package:aikyam/widgets/fillButton.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  var _selectedIntrest;

  @override
  Widget build(BuildContext context) {
    var selectedGender;
    var selectedIndex = -1;
    int _choiceIndex;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
        child: Column(
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
            Container(
              width: double.infinity,
              height: 60.0,
              child: const TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.green,
                  ),
                  hintText: "Enter name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                        style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                        style: BorderStyle.solid),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //contact
            Container(
              width: double.infinity,
              height: 60.0,
              child: const TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                  hintText: "Enter contact",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                        style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                        style: BorderStyle.solid),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //email
            Container(
              width: double.infinity,
              height: 60.0,
              child: const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.green,
                  ),
                  hintText: "Enter email",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                        style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                        style: BorderStyle.solid),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //gender

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: kgreen, width: 2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Gender',
                    style: kText16Regular,
                  ),
                  Chip(label: Text('male', style: kText12Regular)),
                  Chip(label: Text('female', style: kText12Regular)),
                  Chip(label: Text('other', style: kText12Regular)),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //Occupation
            Container(
              width: double.infinity,
              height: 60.0,
              child: const TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.work_outlined,
                    color: Colors.green,
                  ),
                  hintText: "Enter name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                        style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                        style: BorderStyle.solid),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //Interest
            Container(
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                border: Border.all(color: kgreen, width: 2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DropdownButton(
                hint: Row(
                  children: [
                    SizedBox(width: 10.0),
                    Icon(
                      Icons.interests_rounded,
                      color: kgreen,
                    ),
                    SizedBox(width: 10.0),
                    Text('Select intrest'),
                  ],
                ),
                value: _selectedIntrest,
                items: [
                  DropdownMenuItem(
                    child: Text('Option 1'),
                    value: 'Option 1',
                  ),
                  DropdownMenuItem(
                    child: Text('Option 2'),
                    value: 'Option 2',
                  ),
                  DropdownMenuItem(
                    child: Text('Option 3'),
                    value: 'Option 3',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedIntrest = value!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //save
            FillButton(
                buttonText: "Register",
                onPressed: () {
                  Navigator.pushNamed(context, "/user_home");
                })
          ],
        ),
      ),
    );
  }
}
