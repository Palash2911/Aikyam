import 'dart:io';
import 'package:aikyam/models/ngo.dart';
import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/providers/ngo_provider.dart';
import 'package:aikyam/views/Screens/Ngo/NgoProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NgoEditProfile extends StatefulWidget {
  static var routeName = '/ngo-edit-profile';

  const NgoEditProfile({super.key});

  @override
  State<NgoEditProfile> createState() => _NgoEditProfileState();
}

class _NgoEditProfileState extends State<NgoEditProfile> {
  var _selectedIntrest;
  List<Type> type = [];
  List<Registered> ngoReg = [];
  String ngoType = "";
  String ngoRegisterd = "";
  final _form = GlobalKey<FormState>();
  String authToken = "";
  List<dynamic> postId = [];

  final _dateController = TextEditingController();
  final _bioController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _websiteController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _stateController = TextEditingController();
  final _addressController = TextEditingController();
  final _aboutTextController = TextEditingController();

  String get date => _dateController.text;
  String get name => _nameController.text;
  String get phone => _phoneController.text;
  String get email => _emailController.text;
  String get bio => _bioController.text;
  String get zipcode => _zipcodeController.text;
  String get city => _cityController.text;
  String get state => _stateController.text;

  String category = "";
  File? localUrl;
  String firebaseUrl = "";
  var isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    type.add(Type("Profit", false));
    type.add(Type("Non-Profit", false));
    ngoReg.add(Registered("Yes", false));
    ngoReg.add(Registered("No", false));
    _fetchNgo();
  }

  void _fetchNgo() async {
    authToken = Provider.of<Auth>(context, listen: false).token;
    await Provider.of<NgoProvider>(context, listen: false)
        .getNgoDetails(authToken)
        .then((value) {
      _bioController.text = value!.bio;
      _nameController.text = value.name;
      _phoneController.text = value.phone;
      _emailController.text = value.email;
      _cityController.text = value.city;
      _zipcodeController.text = value.zipcode;
      _dateController.text = value.date;
      _stateController.text = value.state;
      ngoType = value.type;
      ngoRegisterd = value.registered;
      if (ngoType == "Profit") {
        type.first.isSelected = true;
      } else {
        type.last.isSelected = true;
      }
      if (ngoRegisterd == "Yes") {
        ngoReg.first.isSelected = true;
      } else {
        ngoReg.last.isSelected = true;
      }
      setState(() {
        isLoading = false;
        firebaseUrl = value.firebaseUrl;
        localUrl = value.localUrl;
        postId = value.postId;
      });
    });
  }

  void _updateDetails() async {
    await Provider.of<NgoProvider>(context, listen: false)
        .updateNgo(
      Ngo(
        id: authToken,
        bio: bio,
        name: name,
        email: email,
        phone: phone,
        localUrl: localUrl,
        firebaseUrl: firebaseUrl,
        type: ngoType,
        date: date,
        registered: ngoRegisterd,
        city: city,
        state: state,
        zipcode: zipcode,
        category: category,
        postId: postId,
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
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const NgoProfile()));
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _dateController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipcodeController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: isLoading
              ? Container(
                  margin: const EdgeInsets.only(top: 150),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
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
                      Form(
                        key: _form,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 250,
                              //height: 10.0,
                              child: TextFormField(
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                controller: _bioController,
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.edit),
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  hintText: 'Description',
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
                                hintText: "NGO Name",
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
                                hintText: "Email id",
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
                            //gender
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_money_rounded,
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
                                        'Ngo Type',
                                        style: kTextPopR14.copyWith(
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(width: 10.0),
                                      SizedBox(
                                        height: 50,
                                        width: 180,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: type.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    type.forEach((types) =>
                                                        types.isSelected =
                                                            false);
                                                    type[index].isSelected =
                                                        true;
                                                    ngoType = type[index].name;
                                                  });
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                    right: 9,
                                                  ),
                                                  child: Chip(
                                                    label: Text(
                                                      type[index].name,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: !type[index]
                                                                  .isSelected
                                                              ? Colors.green
                                                              : Colors.white),
                                                    ),
                                                    backgroundColor:
                                                        !type[index].isSelected
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

                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _aboutTextController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "Tell us more about Ngo",
                                hintStyle: kTextPopR14,
                                icon: const Icon(Icons.location_on_rounded),
                                filled: true,
                                fillColor: Colors.green.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter About Ngo!';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 10.0),

                            TextFormField(
                              controller: _addressController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "Address",
                                hintStyle: kTextPopR14,
                                icon: const Icon(Icons.location_on_rounded),
                                filled: true,
                                fillColor: Colors.green.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter address!';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 40.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: _cityController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "City",
                                        hintStyle: kTextPopR14,
                                        filled: true,
                                        fillColor: Colors.green.shade100,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter city!';
                                        }
                                        return null;
                                      },
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                            TextFormField(
                              controller: _stateController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "State",
                                hintStyle: kTextPopR14,
                                icon: const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.transparent,
                                ),
                                filled: true,
                                fillColor: Colors.green.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter state!';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // border: Border.all(color: kprimaryColor, width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Is NGO Registered?',
                                        style: kTextPopR14,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: ngoReg.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                ngoReg.forEach((reg) =>
                                                    reg.isSelected = false);
                                                ngoReg[index].isSelected = true;
                                                ngoRegisterd =
                                                    ngoReg[index].name;
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 9),
                                              child: Chip(
                                                label: Text(
                                                  ngoReg[index].name,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: !ngoReg[index]
                                                              .isSelected
                                                          ? Colors.green
                                                          : Colors.white),
                                                ),
                                                backgroundColor:
                                                    !ngoReg[index].isSelected
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
                            const SizedBox(height: 25.0),
                            Row(
                              children: [
                                Text(
                                  "Date of Establishment",
                                  textAlign: TextAlign.left,
                                  style: kTextPopR14,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            SizedBox(
                              width: double.infinity,
                              height: 60.0,
                              child: TextFormField(
                                  controller: _dateController,
                                  // onTap: ,
                                  decoration: InputDecoration(
                                    hintText: "Date",
                                    hintStyle: kTextPopR14,
                                    icon: const Icon(
                                      Icons.calendar_today_rounded,
                                    ),
                                    filled: true,
                                    fillColor: Colors.green.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Date Not Set !';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2024));
                                    if (pickedDate != null) {
                                      //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat.yMMMMd('en_US')
                                              .format(pickedDate);
                                      setState(() {
                                        _dateController.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {}
                                  }),
                            ),
                            const SizedBox(height: 15.0),
                            Row(
                              children: [
                                Text(
                                  "NGO focus on",
                                  textAlign: TextAlign.left,
                                  style: kTextPopR14,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            TextFormField(
                              controller: _websiteController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "Address",
                                hintStyle: kTextPopR14,
                                icon: const Icon(Icons.location_on_rounded),
                                filled: true,
                                fillColor: Colors.green.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter address!';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 15.0),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton(
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                hint: Row(
                                  children: [
                                    const SizedBox(width: 10.0),
                                    Icon(
                                      Icons.interests_rounded,
                                      color: kprimaryColor,
                                    ),
                                    const SizedBox(width: 10.0),
                                    const Text('Select a category'),
                                  ],
                                ),
                                value: _selectedIntrest,
                                items: [
                                  'Cleaning',
                                  'Child Care',
                                  'Women Empowerment'
                                ].map((cat) {
                                  return DropdownMenuItem(
                                    value: cat,
                                    child: Text(cat),
                                    onTap: () {
                                      setState(() {
                                        category = cat;
                                      });
                                    },
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedIntrest = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 60, //height of button
                              width: 250, //width of button
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        kprimaryColor, //background color of button
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.all(
                                        20) //content padding inside button
                                    ),
                                onPressed: () {
                                  _updateDetails();
                                  setState(() {
                                    isLoading = true;
                                  });
                                },
                                child: const Text(
                                  "Save",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class Type {
  String name;
  bool isSelected;

  Type(this.name, this.isSelected);
}

class Registered {
  String name;
  bool isSelected;

  Registered(this.name, this.isSelected);
}
