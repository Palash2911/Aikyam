import 'dart:io';

import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/User/HomeScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserRegister extends StatefulWidget {
  static var routeName = "/user-register";
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  var _selectedIntrest;
  final _bioController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _occupationController = TextEditingController();
  final _interestController = TextEditingController();
  final _profileUrlController = TextEditingController();

  String get name => _nameController.text;
  String get phone => _phoneController.text;
  String get email => _emailController.text;
  String get bio => _bioController.text;
  String get occupation => _occupationController.text;
  String get interest => _interestController.text;
  String gender = "";
  File? imageFile;

  List<Gender> genders = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = "";
    _phoneController.text = "";
    _emailController.text = "";
    _bioController.text = "";
    _interestController.text = "";
    _occupationController.text = "";
    _profileUrlController.text = "";
    genders.add(Gender("Male", Icons.male, false));
    genders.add(Gender("Female", Icons.female, false));
    genders.add(Gender("Others", Icons.transgender, false));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _interestController.dispose();
    _occupationController.dispose();
    _profileUrlController.dispose();
    super.dispose();
  }

  Future _createProfile(BuildContext ctx) async {
    var authProvider = Provider.of<Auth>(ctx, listen: false);
    await authProvider
        .registerUser(bio, name, phone, email, gender, occupation, interest, "")
        .catchError((e) {
      print("Failure");
    }).then((_) {
      Navigator.of(ctx).pushReplacementNamed(UserBottomBar.routeName);
    });
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedGender;
    var selectedIndex = -1;
    int _choiceIndex;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              //profile picture
              Stack(
                children: [
                  imageFile != null
                      ? CircleAvatar(
                          radius: 50,
                          child: CircleAvatar(
                            backgroundImage: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            ).image,
                            radius: 60,
                          ),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/group.png"),
                            radius: 60,
                          ),
                        ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: InkWell(
                      onTap: () {
                        _getFromGallery();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                width: 180,
                //height: 10.0,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _bioController,
                  decoration: const InputDecoration(
                    hintText: "Enter Bio",
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 86, 86, 86),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(height: 60.0),
              // name
              Container(
                width: double.infinity,
                height: 60.0,
                child: TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Color.fromARGB(255, 39, 145, 42),
                    ),
                    hintText: "Enter name",
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(height: 10.0),
              //contact
              Container(
                width: double.infinity,
                height: 60.0,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    hintText: "Enter contact no",
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(height: 10.0),
              //email
              Container(
                width: double.infinity,
                height: 60.0,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.green,
                    ),
                    hintText: "Enter Email-ID",
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(height: 10.0),
              //gender
              Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: kprimaryColor, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Gender',
                      style: kTextPopR14,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: genders.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  genders.forEach(
                                      (gender) => gender.isSelected = false);
                                  genders[index].isSelected = true;
                                  gender = genders[index].name;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 9),
                                child: Chip(
                                  label: Text(
                                    genders[index].name,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: !genders[index].isSelected
                                            ? Colors.green
                                            : Colors.white),
                                  ),
                                  backgroundColor: !genders[index].isSelected
                                      ? Colors.white
                                      : Colors.green,
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                height: 60.0,
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: _occupationController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.work,
                      color: Colors.green,
                    ),
                    hintText: "Enter Occupation",
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                height: 60.0,
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: _interestController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.work,
                      color: Colors.green,
                    ),
                    hintText: "Enter Interest",
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 60, //height of button
                width: 250, //width of button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, //background color of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(
                          20) //content padding inside button
                      ),
                  onPressed: () => _createProfile(context),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}
