import 'dart:io';

import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/ngoBottomBar.dart';
import 'package:flutter/material.dart';
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

  final _datecontroller = TextEditingController();
  final _bioController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _stateController = TextEditingController();
  String get date => _datecontroller.text;
  String get name => _nameController.text;
  String get phone => _phoneController.text;
  String get email => _emailController.text;
  String get bio => _bioController.text;
  String get zipcode => _zipcodeController.text;
  String get city => _cityController.text;
  String get state => _stateController.text;
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
    _zipcodeController.text = "";
    _datecontroller.text = "";
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
    _datecontroller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipcodeController.dispose();
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
          .registerNgo(bio, name, phone, email, ngoType, date, ngoRegisterd,
              city, zipcode, state, category, imageFile!)
          .catchError((e) {
        print("Failure");
      }).then((_) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(ctx).pushReplacementNamed(NgoBottomBar.routeName);
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
                            hintText: 'Description',
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
                      TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "NGO Name",
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

                      TextFormField(
                        maxLength: 10,
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: '+91 ',
                          prefixStyle: kTextPopB14,
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
                      TextField(
                        controller: _emailController,
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
                            Icons.attach_money_rounded,
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
                                  'Ngo Type',
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
                                      itemCount: type.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              type.forEach((types) =>
                                                  types.isSelected = false);
                                              type[index].isSelected = true;
                                              ngoType = type[index].name;
                                            });
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 9),
                                            child: Chip(
                                              label: Text(
                                                type[index].name,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        !type[index].isSelected
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
                                SizedBox(width: 10.0),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: 20.0),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.location_on_rounded,
                      //       size: 32.0,
                      //       color: Colors.grey,
                      //     ),
                      //     SizedBox(
                      //       width: 12.0,
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.green.shade100,
                      //         // border: Border.all(color: kprimaryColor, width: 2),
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       child: Row(
                      //         children: [
                      //           SizedBox(width: 10.0),
                      //           Text(
                      //             'Address',
                      //             style: kTextPopR14.copyWith(
                      //                 color: Colors.black54),
                      //           ),
                      //           SizedBox(width: 10.0),
                      //           SizedBox(width: 10.0),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // Row(
                      //   children: [
                      //     const SizedBox(width: 10),
                      //     Text(
                      //       "Location Details",
                      //       textAlign: TextAlign.left,
                      //       style: kTextPopB14,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 10.0),
                      TextField(
                        // controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Address",
                          hintStyle: kTextPopR14,
                          icon: Icon(Icons.location_on_rounded),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: _cityController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  hintText: "City",
                                  hintStyle: kTextPopR14,
                                  filled: true,
                                  fillColor: Colors.green.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                maxLength: 6,
                                controller: _zipcodeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Zip",
                                  hintStyle: kTextPopR14,
                                  filled: true,
                                  fillColor: Colors.green.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.length != 6) {
                                    return 'Zip code must be 6 digits long';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        controller: _stateController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "State",
                          hintStyle: kTextPopR14,
                          icon: Icon(
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
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
                      Divider(),
                      const SizedBox(height: 10),
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
                                  controller: _datecontroller,
                                  // onTap: ,
                                  decoration: InputDecoration(
                                    hintText: "Date",
                                    hintStyle: kTextPopR14,
                                    icon: Icon(
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
                                        _datecontroller.text =
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
                                icon: Icon(Icons.arrow_drop_down_rounded),
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
                            // FloatingActionButton.extended(
                            //   elevation: 0,
                            //   backgroundColor: Colors.green,
                            //   foregroundColor: Colors.green,
                            //   shape: const StadiumBorder(
                            //       side: BorderSide(
                            //           color: Colors.green, width: 1)),
                            //   label: const Text(
                            //     "        Done        ",
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            //   onPressed: () {
                            //     // Navigator.of(context).pushReplacementNamed(NgoBottomBar.routeName);
                            //     setState(() {
                            //       isLoading = true;
                            //     });
                            //     _createProfile(context);
                            //   },
                            // ),
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
