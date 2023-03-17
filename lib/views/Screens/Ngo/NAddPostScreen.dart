import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NgoAddpost extends StatefulWidget {
  const NgoAddpost({super.key});

  static const routeName = '/ngo_add_post';

  @override
  State<NgoAddpost> createState() => _NgoAddpostState();
}

class _NgoAddpostState extends State<NgoAddpost> {
  List<String> categories = [
    "Health",
    "Education",
    "Environment",
    "Poverty",
    "Human Rights",
    "Animals",
  ];
  String? selectedCategory;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _driveTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _noofVoluntersController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 80,
          flexibleSpace: RoundAppBar(
            title: 'Create Post',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      _addImage(),
                      _addImage(),
                      _addImage(),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _driveTitleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Write the title of the drive',
                      alignLabelWithHint: true,
                      labelText: 'Drive Title',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    minLines: 1,
                    maxLines: 10,
                    controller: _driveTitleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Write what will be in the drive',
                      alignLabelWithHint: true,
                      labelText: 'Drive description',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: kinputColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      hint: Text('Select a category'),
                      value: selectedCategory,
                      items: categories.map((String category) {
                        return new DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _noofVoluntersController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'How many people you required for drive',
                      alignLabelWithHint: true,
                      labelText: 'Number of volunteers',
                    ),
                  ),
                  SizedBox(height: 16),
                  // SizedBox(
                  //   height: 60.0,
                  //   child: TextFormField(
                  //     controller: _dateController,
                  //     decoration: InputDecoration(
                  //       hintText: "Date of drive",
                  //       hintStyle: kTextPopR14,
                  //       icon: const Icon(
                  //         Icons.calendar_today_rounded,
                  //       ),
                  //       filled: true,
                  //       fillColor: Colors.green.shade100,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Date Not Set !';
                  //       }
                  //       return null;
                  //     },
                  //     readOnly: true,
                  //     onTap: () async {
                  //       DateTime? pickedDate = await showDatePicker(
                  //           context: context,
                  //           initialDate: DateTime.now(),
                  //           firstDate: DateTime(1950),
                  //           lastDate: DateTime(2024));
                  //       if (pickedDate != null) {
                  //         String formattedDate =
                  //             DateFormat.yMMMMd('en_US').format(pickedDate);
                  //         setState(() {
                  //           _dateController.text = formattedDate;
                  //         });
                  //       } else {}
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // SizedBox(
                  //   height: 60.0,
                  //   child: TextFormField(
                  //     controller: _timeController,
                  //     decoration: InputDecoration(
                  //       hintText: "Time of drive",
                  //       hintStyle: kTextPopR14,
                  //       icon: const Icon(
                  //         Icons.access_time_rounded,
                  //       ),
                  //       filled: true,
                  //       fillColor: Colors.green.shade100,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Time Not Set !';
                  //       }
                  //       return null;
                  //     },
                  //     readOnly: true,
                  //     onTap: () async {
                  //       TimeOfDay? pickedTime = await showTimePicker(
                  //         context: context,
                  //         initialTime: TimeOfDay.now(),
                  //       );
                  //       if (pickedTime != null) {
                  //         String formattedTime = pickedTime.format(context);
                  //         setState(() {
                  //           _timeController.text = formattedTime;
                  //         });
                  //       } else {}
                  //     },
                  //   ),
                  // ),
                  // SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextFormField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              hintText: "Date of drive",
                              hintStyle: kTextPopR14,
                              icon: const Icon(Icons.calendar_today_rounded),
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
                                String formattedDate =
                                    DateFormat.yMMMMd('en_US')
                                        .format(pickedDate);
                                setState(() {
                                  _dateController.text = formattedDate;
                                });
                              } else {}
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            controller: _timeController,
                            decoration: InputDecoration(
                              hintText: "Time of drive",
                              hintStyle: kTextPopR14,
                              icon: const Icon(Icons.access_time_rounded),
                              filled: true,
                              fillColor: Colors.green.shade100,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Time Not Set !';
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                String formattedTime =
                                    pickedTime.format(context);
                                setState(() {
                                  _timeController.text = formattedTime;
                                });
                              } else {}
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      labelText: 'Address',
                    ),
                  ),
                  SizedBox(height: 16),
                  CSCPicker(
                    showCities: true,
                    countryFilter: [
                      CscCountry.India,
                    ],
                    dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: kinputColor,
                      border: Border.all(color: kinputColor, width: 2),
                    ),
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: kinputColor,
                        border: Border.all(color: kinputColor, width: 1)),
                    layout: Layout.vertical,
                    onCountryChanged: (country) {},
                    onStateChanged: (state) {
                      _stateController.text = state.toString();
                    },
                    onCityChanged: (city) {
                      _cityController.text = city.toString();
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(onPressed: () {}, child: Text('Post'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _addImage extends StatelessWidget {
  const _addImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 100,
        height: 100,
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
