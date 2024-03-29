import 'package:aikyam/models/post.dart';
import 'package:aikyam/providers/ngo_provider.dart';
import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/views/Screens/Ngo/NActivityScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:aikyam/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NgoEditPost extends StatefulWidget {
  final String pid;
  const NgoEditPost({super.key, required this.pid});

  @override
  State<NgoEditPost> createState() => _NgoEditPost();
}

class _NgoEditPost extends State<NgoEditPost> {
  List<String> categories = [
    "Select Category",
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
  final TextEditingController _noVoluntersController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  String get address => _addressController.text;
  String get driveTitle => _driveTitleController.text;
  String get description => _descriptionController.text;
  String get noofVolunteers => _noVoluntersController.text;
  String get date => _dateController.text;
  String get time => _timeController.text;
  String get state => _stateController.text;
  String get city => _cityController.text;

  var isLoading = false;
  List<dynamic> postImages = [];

  @override
  void initState() {
    super.initState();
    setFields();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _driveTitleController.dispose();
    _descriptionController.dispose();
    _noVoluntersController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void setFields() async {
    setState(() {
      isLoading = true;
    });
    var postProvider = Provider.of<PostProvider>(context, listen: false);
    await postProvider.getPostDetails(widget.pid).then((value) {
      if (value != null) {
        _addressController.text = value.address;
        _driveTitleController.text = value.driveTitle;
        _descriptionController.text = value.description;
        _noVoluntersController.text = value.noofVolunters;
        _dateController.text = value.date;
        _timeController.text = value.time;
        _stateController.text = value.state;
        _cityController.text = value.city;
        postImages = value.photos;
        var inx = categories.indexWhere((element) => (element == value.category));
        selectedCategory = categories[inx];
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  Future _updatePost(BuildContext ctx) async {
    var authProvider = Provider.of<Auth>(ctx, listen: false);
    var postProvider = Provider.of<PostProvider>(ctx, listen: false);
    var ngoProvider = Provider.of<NgoProvider>(ctx, listen: false);
    final isValid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    _formKey.currentState!.save();
    if (isValid) {
      var ngoDetails = await ngoProvider.getNgoDetails(authProvider.token);
      if (ngoDetails != null) {
        await postProvider
            .updatePost(
          Post(
            ncity: ngoDetails.city,
            ngoname: ngoDetails.name,
            category: selectedCategory!,
            description: description,
            ngoid: authProvider.token,
            id: widget.pid,
            noofVolunters: noofVolunteers,
            date: date,
            time: time,
            city: city,
            driveTitle: driveTitle,
            state: state,
            address: address,
            country: "India",
            photos: postImages,
          ),
        )
            .catchError((e) {
          Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: kprimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }).then((_) {
          Fluttertoast.showToast(
            msg: "Post Edited Successfully !!",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: kprimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          setState(() {
            isLoading = false;
          });
          setFields();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const NgoActivityScreen(),
            ),
          );
        });
      } else {
        setState(() {
          isLoading = false;
        });
        return;
      }
    }
  }

  Future _getFromGallery(int index) async {
    Fluttertoast.showToast(
      msg: "Cannot Edit Pictures",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: kprimaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    // PickedFile? pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    //   maxWidth: 1800,
    //   maxHeight: 1800,
    // );
    // if (pickedFile != null) {
    //   if (index == 0) {
    //     if (postImages.isEmpty) {
    //       postImages.add(pickedFile.path);
    //     } else {
    //       postImages[0] = pickedFile.path;
    //     }
    //   } else if (index == 1) {
    //     if (postImages.length == 1) {
    //       postImages.add(pickedFile.path);
    //     } else {
    //       postImages[1] = pickedFile.path;
    //     }
    //   } else {
    //     if (postImages.length == 2) {
    //       postImages.add(File(pickedFile.path));
    //     } else {
    //       postImages[2] = File(pickedFile.path);
    //     }
    //   }
    //   setState(() {});
    // }
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
            title: '    Edit Post',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Container(
                    margin: const EdgeInsets.only(top: 27),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            _addImage(
                              imageFile:
                                  postImages.isNotEmpty ? postImages[0] : null,
                              onTap: () => _getFromGallery(0),
                            ),
                            _addImage(
                              imageFile: postImages.isNotEmpty
                                  ? postImages.length >= 2
                                      ? postImages[1]
                                      : null
                                  : null,
                              onTap: () => _getFromGallery(0),
                            ),
                            _addImage(
                              imageFile: postImages.isNotEmpty
                                  ? postImages.length == 3
                                      ? postImages[2]
                                      : null
                                  : null,
                              onTap: () => _getFromGallery(0),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          textInputAction: TextInputAction.next,
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
                        const SizedBox(height: 10.0),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          minLines: 1,
                          maxLines: 10,
                          controller: _descriptionController,
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
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: kinputColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButton<String>(
                            hint: const Text('Select a category'),
                            value: selectedCategory,
                            items: categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _noVoluntersController,
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
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                    hintText: "Date of drive",
                                    hintStyle: kTextPopR14,
                                    icon: const Icon(
                                        Icons.calendar_today_rounded),
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
                                  textInputAction: TextInputAction.next,
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
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
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
                        const SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.next,
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
                        const SizedBox(height: 16),
                        CSCPicker(
                          currentCity: _cityController.text,
                          currentState: _stateController.text,
                          currentCountry: "India",
                          showCities: true,
                          countryFilter: const [
                            CscCountry.India,
                          ],
                          dropdownDecoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
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
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _updatePost(context);
                          },
                          child: Text(
                            'Update Post',
                            style: kTextPopB16,
                          ),
                        )
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
  _addImage({
    required this.imageFile,
    required this.onTap,
  });
  final String? imageFile;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: imageFile != null
          ? SizedBox(
              width: 100,
              height: 100,
              child: InkWell(
                onTap: onTap,
                child: Image.network(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : SizedBox(
              width: 100,
              height: 100,
              child: InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.grey[700],
                ),
              ),
            ),
    );
  }
}
