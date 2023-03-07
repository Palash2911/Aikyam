import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:aikyam/views/Screens/Ngo/RegisterScreen2.dart';

class NgoRegister extends StatefulWidget {
  static var routeName = '/ngo-register';

  const NgoRegister({super.key});

  @override
  State<NgoRegister> createState() => _NgoRegisterState();
}

class _NgoRegisterState extends State<NgoRegister> {
  var _selectedIntrest;

  @override
  Widget build(BuildContext context) {
    var selectedGender;
    var selectedIndex = -1;
    int _choiceIndex;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 30,
        ),
        elevation: 0,
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register2()));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    radius: 50,
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
                width: double.infinity,
                height: 60.0,
                child: const TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Color.fromARGB(255, 39, 145, 42),
                    ),
                    hintText: "Enter name",
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
                    hintText: "Enter contact no",
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
                    hintText: "Enter Email-ID",
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              //gender

              Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: kprimaryColor, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Type',
                      style: kTextPopR12,
                    ),
                    Chip(
                      label: Text('Profit',
                          style: TextStyle(fontSize: 12, color: Colors.green)),
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                    Chip(
                      label: Text('Non-Profit',
                          style: TextStyle(fontSize: 12, color: Colors.green)),
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                    Chip(
                      label: Text('Other',
                          style: TextStyle(fontSize: 12, color: Colors.green)),
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    "Address",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Spacer(),
                ],
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: new Row(children: <Widget>[
                    const SizedBox(
                        width: 90.0,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "City",
                            focusColor: Colors.green,
                          ),
                        )),
                    SizedBox(width: 12),
                    const SizedBox(
                        width: 90.0,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Zipcode",
                          ),
                        )),
                    SizedBox(width: 12),
                    const SizedBox(
                        width: 90.0,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "State",
                          ),
                        ))
                  ])),
              SizedBox(height: 15),
              FloatingActionButton.extended(
                elevation: 0,
                foregroundColor: Colors.green,
                shape: const StadiumBorder(
                    side: BorderSide(color: Colors.green, width: 1)),
                label: Text(
                  "Locate on Map",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register2()));
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
