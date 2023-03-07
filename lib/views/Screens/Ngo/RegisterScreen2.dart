import 'package:aikyam/views/Screens/Ngo/OTP.dart';
import 'package:aikyam/views/Screens/User/HomeScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/ngoBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aikyam/views/widgets/EditImage.dart';

class Register2 extends StatefulWidget {
  const Register2({super.key});

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                      backgroundImage: AssetImage("assets/images/group.png"),
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
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 180,
                //height: 10.0,
                child: const TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Description",
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 86, 86, 86),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              // name

              Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: kprimaryColor, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Is NGO registered?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    Spacer(),
                    Chip(
                      label: Text('Yes',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                      backgroundColor: Colors.green,
                    ),
                    Chip(
                      label: Text('No',
                          style: TextStyle(fontSize: 12, color: Colors.green)),
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Text(
                    "Date of Establishment",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 60.0,
                child: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: Colors.green,
                    ),
                    hintText: "dd-mm-yyyy",
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Text(
                    "NGO focus on",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 207, 207, 207), width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: DropdownButton(
                  hint: Row(
                    children: [
                      SizedBox(width: 10.0),
                      Icon(
                        Icons.interests_rounded,
                        color: kprimaryColor,
                      ),
                      SizedBox(width: 10.0),
                      Text('Select a category'),
                    ],
                  ),
                  value: _selectedIntrest,
                  items: [
                    DropdownMenuItem(
                      child: Text('Cleaning'),
                      value: 'Cleaning',
                    ),
                    DropdownMenuItem(
                      child: Text('Child Care'),
                      value: 'Child Care',
                    ),
                    DropdownMenuItem(
                      child: Text('Women Empowerment'),
                      value: 'Women Empowerment',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedIntrest = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 70),
              FloatingActionButton.extended(
                elevation: 0,
                backgroundColor: Colors.green,
                foregroundColor: Colors.green,
                shape: const StadiumBorder(
                    side: BorderSide(color: Colors.green, width: 1)),
                label: Text(
                  "        Done        ",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(NgoBottomBar.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
