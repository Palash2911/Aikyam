import 'dart:io';
import 'package:aikyam/models/ngo.dart';
import 'package:aikyam/providers/ngo_provider.dart';
import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/ngoBottomBar.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NgoRegister extends StatefulWidget {
  static var routeName = '/ngo-register';

  const NgoRegister({super.key});

  @override
  State<NgoRegister> createState() => _NgoRegisterState();
}

class _NgoRegisterState extends State<NgoRegister> {
  var _selectedIntrest;
  List<Type> type = [];
  List<Registered> ngoReg = [];
  String ngoType = "";
  String ngoRegisterd = "";
  final _form = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final _websiteController = TextEditingController();
  final _bioController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _aboutController = TextEditingController();

  String get date => _dateController.text;
  String get name => _nameController.text;
  String get phone => _phoneController.text;
  String get email => _emailController.text;
  String get bio => _bioController.text;
  String get about => _aboutController.text;
  String get city => _cityController.text;
  String get state => _stateController.text;
  String get address => _addressController.text;
  String get website => _websiteController.text;

  String category = "";
  File? imageFile;
  var isLoading = false;

  @override
  void initState() {
    _nameController.text = "";
    _phoneController.text = "";
    _emailController.text = "";
    _bioController.text = "";
    _cityController.text = "";
    _stateController.text = "";
    _aboutController.text = "";
    _dateController.text = "";
    _addressController.text = "";
    _websiteController.text = "";
    type.add(Type("Profit", false));
    type.add(Type("Non-Profit", false));
    ngoReg.add(Registered("Yes", false));
    ngoReg.add(Registered("No", false));
    super.initState();
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
    _aboutController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  Future _createProfile(BuildContext ctx) async {
    var authProvider = Provider.of<Auth>(ctx, listen: false);
    var ngoProvider = Provider.of<NgoProvider>(ctx, listen: false);
    final isValid = _form.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    _form.currentState!.save();
    if (isValid) {
      if (imageFile == null) {
        Fluttertoast.showToast(
          msg: "Please select Profile pic!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        await ngoProvider
            .registerNgo(
          Ngo(
            id: authProvider.token,
            bio: bio,
            name: name,
            email: email,
            phone: phone,
            type: ngoType,
            date: date,
            registered: ngoRegisterd,
            city: city,
            state: state,
            about: about,
            category: category,
            localUrl: imageFile,
            firebaseUrl: "",
            postId: [],
            address: address,
            webUrl: website,
          ),
        )
            .catchError((e) {
          Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }).then((_) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(ctx).pushReplacementNamed(NgoBottomBar.routeName);
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
                            // Row(
                            //   children: [
                            //     const SizedBox(width: 10),
                            //     Text(
                            //       "Ngo Details",
                            //       textAlign: TextAlign.left,
                            //       style: kTextPopB14,
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(width: 20),

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
                              minLines: 1,
                              maxLines: 10,
                              controller: _aboutController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "Tell us more about Ngo",
                                hintStyle: kTextPopR14,
                                icon: const Icon(Icons.info_outline_rounded),
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
                              minLines: 1,
                              maxLines: 2,
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

                            const SizedBox(height: 10),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 30.0),
                              child: CSCPicker(
                                showCities: true,
                                countryFilter: const [
                                  CscCountry.India,
                                ],
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: kinputColor,
                                  border:
                                      Border.all(color: kinputColor, width: 2),
                                ),
                                disabledDropdownDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: kinputColor,
                                    border: Border.all(
                                        color: kinputColor, width: 1)),
                                layout: Layout.vertical,
                                onCountryChanged: (country) {},
                                onStateChanged: (state) {
                                  _stateController.text = state.toString();
                                },
                                onCityChanged: (city) {
                                  _cityController.text = city.toString();
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
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
                            TextFormField(
                              controller: _websiteController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "Website Url",
                                hintStyle: kTextPopR14,
                                icon: const Icon(Icons.link),
                                filled: true,
                                fillColor: Colors.green.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter url!';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 15.0),
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
                                  'Human rights',
                                  'Environmental',
                                  'Health',
                                  'Education',
                                  'Women\'s',
                                  'Children\'s',
                                  'Animal welfare',
                                  'Development ',
                                  'Peace',
                                  'Other'
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
                                    primary: Colors
                                        .green, //background color of button
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.all(
                                        20) //content padding inside button
                                    ),
                                onPressed: () {
                                  // Navigator.of(context).pushReplacementNamed(NgoBottomBar.routeName);
                                  setState(() {
                                    isLoading = true;
                                  });
                                  _createProfile(context);
                                },
                                child: const Text(
                                  "Register",
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
