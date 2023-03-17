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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _noofVoluntersController = TextEditingController();
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
                      Card(
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
                      ),
                    ],
                  ),
                  TextFormField(
                    maxLines: 10,
                    controller: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Write what will be in the drive',
                      alignLabelWithHint: true,
                      labelText: 'Drive description',
                    ),
                  ),
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
                      hintText: 'How many people you required for drive',
                      alignLabelWithHint: true,
                      labelText: 'Number of volunteers',
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: TextFormField(
                        controller: _dateController,
                        // onTap: ,
                        decoration: InputDecoration(
                          hintText: "Date of drive",
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
                                DateFormat.yMMMMd('en_US').format(pickedDate);
                            setState(() {
                              _dateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        }),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: TextFormField(
                      controller: _timeController,
                      decoration: InputDecoration(
                        hintText: "Time of drive",
                        hintStyle: kTextPopR14,
                        icon: const Icon(
                          Icons.access_time_rounded,
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
                          String formattedTime = pickedTime.format(context);
                          setState(() {
                            _timeController.text = formattedTime;
                          });
                        } else {}
                      },
                    ),
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
                      labelText: 'Address',
                    ),
                  ),
                  SizedBox(height: 16),
                  CSCPicker(
                    showCities: true,
                    // showStates: false,
                    countryFilter: [
                      CscCountry.India,
                    ],
                    dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: ksecondaryColor,
                      border: Border.all(color: ksecondaryColor, width: 2),
                    ),
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: ksecondaryColor,
                        border: Border.all(color: ksecondaryColor, width: 1)),
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
