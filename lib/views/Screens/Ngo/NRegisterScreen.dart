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
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading
            ? Container(
                margin: const EdgeInsets.only(top: 150),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
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
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: 180,
                      //height: 10.0,
                      child: TextField(
                        controller: _bioController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Description",
                          prefixIcon: Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 86, 86, 86),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    // name
                    SizedBox(
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
                          hintText: "Enter NGO Name",
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    //contact
                    SizedBox(
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
                          hintText: "Enter NGO Contact No",
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    //email
                    SizedBox(
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
                          hintText: "Enter NGO Email-ID",
                        ),
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
                            'Type',
                            style: kTextPopR14,
                          ),
                          SizedBox(
                            height: 30,
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
                                            types.isSelected = false);
                                        type[index].isSelected = true;
                                        ngoType = type[index].name;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 9),
                                      child: Chip(
                                        label: Text(
                                          type[index].name,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: !type[index].isSelected
                                                  ? Colors.green
                                                  : Colors.white),
                                        ),
                                        backgroundColor: !type[index].isSelected
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
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          "Address",
                          textAlign: TextAlign.left,
                          style: kTextPopB14,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                              width: 80.0,
                              child: TextField(
                                keyboardType: TextInputType.name,
                                controller: _cityController,
                                decoration: const InputDecoration(
                                  hintText: "City",
                                  focusColor: Colors.green,
                                ),
                              )),
                          const SizedBox(width: 12),
                          SizedBox(
                              width: 80.0,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _zipcodeController,
                                decoration: const InputDecoration(
                                  hintText: "Zipcode",
                                ),
                              )),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 80.0,
                            child: TextField(
                              controller: _stateController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                hintText: "State",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
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
                                              ngoRegisterd = ngoReg[index].name;
                                            });
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 9),
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
                                style: kTextPopB14,
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
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  labelText: "Choose Date",
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
                                style: kTextPopB14,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 207, 207, 207),
                                  width: 1),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButton(
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
                          FloatingActionButton.extended(
                            elevation: 0,
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.green,
                            shape: const StadiumBorder(
                                side:
                                    BorderSide(color: Colors.green, width: 1)),
                            label: const Text(
                              "        Done        ",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              // Navigator.of(context).pushReplacementNamed(NgoBottomBar.routeName);
                              setState(() {
                                isLoading = true;
                              });
                              _createProfile(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
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
