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
  List<Gender> genders = [];
  final _bioController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _occupationController = TextEditingController();
  final _interestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var selectedGender;
    var selectedIndex = -1;
    int _choiceIndex;
    return SafeArea(
      child: Scaffold(
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
          toolbarHeight: 80,
          flexibleSpace: RoundAppBar(
            title: '      Edit Profile',
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
                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  // controller: _bioController,
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
                  // controller: _nameController,
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
                  // controller: _phoneController,
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
                  // controller: _emailController,
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
                            style: kTextPopR14.copyWith(color: Colors.black54),
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
                                        // gender = genders[index].name;
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
                  // controller: _occupationController,
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
                  // controller: _interestController,
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

                SizedBox(
                  height: 10.0,
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
