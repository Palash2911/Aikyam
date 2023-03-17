import 'dart:io';
import 'package:aikyam/providers/user_provider.dart';
import 'package:aikyam/models/users.dart';
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
  final _form = GlobalKey<FormState>();

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
    var userProvider = Provider.of<UserProvider>(ctx, listen: false);
    final isValid = _form.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    _form.currentState!.save();
    if (isValid) {
      if (imageFile == null) {
        print("Please Select Profile Pic");
        setState(() {
          isLoading = false;
        });
      } else {
        print("hi");
        await userProvider
            .registerUser(
          Users(
            id: authProvider.token,
            bio: bio,
            name: name,
            email: email,
            phone: phone,
            gender: gender,
            occupation: occupation,
            interest: interest,
            profile: imageFile!,
          ),
        )
            .catchError((e) {
          print("Failure");
        }).then((_) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(ctx).pushReplacementNamed(UserBottomBar.routeName);
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      return;
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
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: imageFile != null
                                      ? const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        )
                                      : const Icon(
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
                      Form(
                        key: _form,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 200,
                              //height: 10.0,
                              child: TextFormField(
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
                                        style: kTextPopR14.copyWith(
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
                                                        gender.isSelected =
                                                            false);
                                                    genders[index].isSelected =
                                                        true;
                                                    gender =
                                                        genders[index].name;
                                                  });
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 9),
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
                                                        !genders[index]
                                                                .isSelected
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
                            const SizedBox(height: 20.0),
                            SizedBox(
                              height: 60, //height of button
                              width: 250, //width of button
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .green, //background color of button
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                      const SizedBox(height: 20.0),
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
