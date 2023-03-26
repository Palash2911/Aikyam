import 'dart:io';

import 'package:aikyam/models/users.dart';
import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/providers/user_provider.dart';
import 'package:aikyam/views/Screens/User/UserProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  List<Gender> genders = [];
  final _bioController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _occupationController = TextEditingController();
  final _interestController = TextEditingController();
  File? localUrl;
  String firebaseUrl = "";
  String gender = "";
  String authToken = "";

  String get name => _nameController.text;
  String get phone => _phoneController.text;
  String get email => _emailController.text;
  String get bio => _bioController.text;
  String get occupation => _occupationController.text;
  String get interest => _interestController.text;

  var isLoading = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _occupationController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    genders.add(Gender("Male", Icons.male, false));
    genders.add(Gender("Female", Icons.female, false));
    genders.add(Gender("Others", Icons.transgender, false));
    _fetchUser();
  }

  void _fetchUser() async {
    authToken = Provider.of<Auth>(context, listen: false).token;
    await Provider.of<UserProvider>(context, listen: false)
        .getUserDetails(authToken)
        .then((value) {
      _bioController.text = value!.bio;
      _nameController.text = value.name;
      _phoneController.text = value.phone;
      _emailController.text = value.email;
      _occupationController.text = value.occupation;
      _interestController.text = value.interest;
      gender = value.gender;
      if (gender == "Male") {
        genders.first.isSelected = true;
      } else if (gender == "Female") {
        genders[1].isSelected = true;
      } else {
        genders.last.isSelected = true;
      }
      setState(() {
        isLoading = false;
        firebaseUrl = value.firebaseUrl;
        localUrl = value.localUrl;
      });
    });
  }

  Future _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        localUrl = File(pickedFile.path);
      });
    }
  }

  void _updateDetails() async {
    await Provider.of<UserProvider>(context, listen: false)
        .updateUser(
      Users(
        id: authToken,
        bio: bio,
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        occupation: occupation,
        interest: interest,
        localUrl: localUrl,
        firebaseUrl: firebaseUrl,
      ),
    )
        .then((value) {
      if (isLoading) {
        Fluttertoast.showToast(
          msg: "Profile Updated Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfile(
                      isUser: true,
                      authToken: authToken,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 80,
          flexibleSpace: const RoundAppBar(
            title: '      Edit Profile',
          ),
        ),
        body: isLoading
            ? Center(
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset(
                    'assets/images/loading.gif',
                    fit: BoxFit.contain,
                  ),
                ),
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
                          CircleAvatar(
                            radius: 50,
                            child: CircleAvatar(
                              backgroundImage: localUrl != null
                                  ? Image.file(
                                      localUrl!,
                                      fit: BoxFit.cover,
                                    ).image
                                  : Image.network(
                                      firebaseUrl,
                                      fit: BoxFit.cover,
                                    ).image,
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
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: _bioController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.edit),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: 'Bio',
                          hintStyle: kTextPopR14,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter bio!';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 20.0),
                      // name
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: kTextPopR14,
                          icon: const Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter name!';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 10.0),
                      //contact
                      TextFormField(
                        maxLength: 10,
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: "Contact number",
                          hintStyle: kTextPopR14,
                          icon: const Icon(Icons.phone),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          final phoneRegex = RegExp(r'^\+?\d{9,15}$');
                          if (!phoneRegex.hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10.0),
                      //email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email-Id",
                          hintStyle: kTextPopR14,
                          icon: const Icon(Icons.email_rounded),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Email-Id!';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 10.0),
                      //  Gender
                      Row(
                        children: [
                          const Icon(
                            Icons.male_rounded,
                            size: 32.0,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 12.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              // border: Border.all(color: kprimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10.0),
                                Text(
                                  'Gender',
                                  style: kTextPopB14.copyWith(
                                      color: Colors.black54),
                                ),
                                const SizedBox(width: 9.0),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _occupationController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Occupation",
                          hintStyle: kTextPopR14,
                          icon: const Icon(Icons.work_rounded),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter occupation!';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _interestController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Interest",
                          hintStyle: kTextPopR14,
                          icon: const Icon(Icons.interests_rounded),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter interest!';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 18.0),
                      SizedBox(
                        height: 50, //height of button
                        width: 250, //width of button
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary:
                                  kprimaryColor, //background color of button
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(
                                  10) //content padding inside button
                              ),
                          onPressed: () {
                            _updateDetails();
                            setState(() {
                              isLoading = true;
                            });
                          },
                          child: Text(
                            "Save",
                            style: kTextPopM16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
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
