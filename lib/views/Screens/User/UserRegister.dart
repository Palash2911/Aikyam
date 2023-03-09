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

  String get name => _nameController.text;
  String get phone => _phoneController.text;
  String get email => _emailController.text;
  String get bio => _bioController.text;
  String get occupation => _occupationController.text;
  String get interest => _interestController.text;
  String gender = "";
  File? imageFile;
  var isLoading = false;

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
    super.dispose();
  }

  Future _createProfile(BuildContext ctx) async {
    var authProvider = Provider.of<Auth>(ctx, listen: false);
    setState(() {
      isLoading = true;
    });
    if (imageFile == null) {
      print("Please Select Profile Pic");
    } else {
      await authProvider
          .registerUser(
              bio, name, phone, email, gender, occupation, interest, imageFile!)
          .catchError((e) {
        print("Failure");
      }).then((_) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(ctx).pushReplacementNamed(UserBottomBar.routeName);
      });
    }
  }

  Future _getFromGallery() async {
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
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 0.0),
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
                                  child:
                                      //  imageFile == null ? Icon(
                                      //   Icons.edit,
                                      //   color: Colors.white,
                                      // ):
                                      Icon(
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

                      //bio textfield
                      Container(
                        width: 250,
                        //height: 10.0,
                        child: TextField(
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          controller: _bioController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.edit),
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            hintText: 'Enter bio',
                            hintStyle: kTextPopR14,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // name
                      TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: kTextPopR14,
                          icon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 10.0),
                      //contact
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Contact number",
                          hintStyle: kTextPopR14,
                          icon: Icon(Icons.phone),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 10.0),
                      //email
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email id",
                          hintStyle: kTextPopR14,
                          icon: Icon(Icons.email_rounded),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 10.0),
                      //gender
                      Row(
                        children: [
                          Icon(
                            Icons.male_rounded,
                            size: 32.0,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              // border: Border.all(color: kprimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 10.0),
                                Text(
                                  'Gender',
                                  style: kTextPopR14.copyWith(
                                      color: Colors.black54),
                                ),
                                SizedBox(width: 10.0),
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
                                              genders.forEach((gender) =>
                                                  gender.isSelected = false);
                                              genders[index].isSelected = true;
                                              gender = genders[index].name;
                                            });
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 9),
                                            child: Chip(
                                              label: Text(
                                                genders[index].name,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: !genders[index]
                                                            .isSelected
                                                        ? Colors.green
                                                        : Colors.white),
                                              ),
                                              backgroundColor:
                                                  !genders[index].isSelected
                                                      ? Colors.white
                                                      : Colors.green,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(width: 10.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      TextField(
                        controller: _occupationController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Occupation",
                          hintStyle: kTextPopR14,
                          icon: Icon(Icons.work_rounded),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10.0),

                      TextField(
                        controller: _interestController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Intrest",
                          hintStyle: kTextPopR14,
                          icon: Icon(Icons.interests_rounded),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   height: 60.0,
                      //   child: TextField(
                      //     keyboardType: TextInputType.name,
                      //     controller: _occupationController,
                      //     decoration: const InputDecoration(
                      //       prefixIcon: Icon(
                      //         Icons.work,
                      //         color: Colors.green,
                      //       ),
                      //       hintText: "Enter Occupation",
                      //     ),
                      //     textInputAction: TextInputAction.next,
                      //   ),
                      // ),
                      // Container(
                      //   width: double.infinity,
                      //   height: 60.0,
                      //   child: TextField(
                      //     keyboardType: TextInputType.name,
                      //     controller: _interestController,
                      //     decoration: const InputDecoration(
                      //       prefixIcon: Icon(
                      //         Icons.work,
                      //         color: Colors.green,
                      //       ),
                      //       hintText: "Enter Interest",
                      //     ),
                      //     textInputAction: TextInputAction.done,
                      //   ),
                      // ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        height: 60, //height of button
                        width: 250, //width of button
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary:
                                  Colors.green, //background color of button
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(
                                  20) //content padding inside button
                              ),
                          onPressed: () => _createProfile(context),
                          child: const Text(
                            "Register",
                          ),
                        ),
                      ),
                    ],
                  ),
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
