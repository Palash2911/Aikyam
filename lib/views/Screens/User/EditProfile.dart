import 'package:aikyam/views/Screens/User/HomeScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var _selectedIntrest;

  @override
  Widget build(BuildContext context) {
    var selectedGender;
    var selectedIndex = -1;
    int _choiceIndex;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: Icon(
          Icons.save,
          color: kprimaryColor,
          size: 30,
        ),
        elevation: 0,
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        flexibleSpace: RoundAppBar(
          title: 'Edit Profile',
        ),
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
                    hintText: "Edit Bio",
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 86, 86, 86),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
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
                      'Gender',
                      style: kTextPopR12,
                    ),
                    Chip(
                      label: Text('Male',
                          style: TextStyle(fontSize: 12, color: Colors.green)),
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                    Chip(
                      label: Text('Female',
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
              Container(
                width: double.infinity,
                height: 60.0,
                child: const TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.work,
                      color: Colors.green,
                    ),
                    hintText: "Enter Occupation",
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                height: 60.0,
                child: const TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.work,
                      color: Colors.green,
                    ),
                    hintText: "Enter Interest",
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
