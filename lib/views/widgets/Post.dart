import 'package:aikyam/models/post.dart';
import 'package:aikyam/providers/ngo_provider.dart';
import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/views/widgets/viewPostDetailsScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NgoProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostItem extends StatefulWidget {
  final Post post;
  final String userType;
  final String applyStatus;

  const PostItem({
    required this.userType,
    required this.post,
    required this.applyStatus,
  });

  @override
  State<PostItem> createState() => _PostState();
}

class _PostState extends State<PostItem> {
  bool _isApply = true;
  bool _isLoading = false;
  var profile = "";
  var applyStatus = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getProfile();
  }

  void _getProfile() async {
    await Provider.of<NgoProvider>(context, listen: false)
        .getNgoDetails(widget.post.ngoid)
        .then((value) {
      var date = DateTime.now();
      var postDate = DateFormat('MMMM d, y').parse(widget.post.date);
      if (date.isAfter(postDate)) {
        applyStatus = "Expired";
      } else {
        applyStatus = widget.applyStatus;
      }
      setState(() {
        profile = value!.firebaseUrl;
      });
    });
  }

  Future applyPost() async {
    if (_isApply && widget.applyStatus == "Apply") {
      var postProvider = Provider.of<PostProvider>(context, listen: false);
      await postProvider
          .applyPost(widget.post.id, widget.userType)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kpostColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NgoProfile(
                          authToken: widget.post.ngoid,
                          isUser: false,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      color: Colors.grey,
                      child: profile.isNotEmpty
                          ? Image.network(profile)
                          : Image.asset('assets/images/user.png'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.post.ngoname,
                          style: kTextPopB14,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.post.ncity, style: kTextPopR14),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "Feature Coming Soon..!!",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: kprimaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                  child: const Icon(
                    Icons.share,
                    size: 32.0,
                  ),
                ),
              ],
            ),
            const Divider(),
            Text(
              widget.post.driveTitle,
              style: kTextPopM16,
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                const Icon(Icons.location_city),
                const SizedBox(width: 5),
                Text('City: ', style: kTextPopB14),
                Text(widget.post.city, style: kTextPopR14)
              ],
            ),
            const SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.calendar_month_rounded),
                const SizedBox(width: 5),
                Text('Date: ', style: kTextPopB14),
                Expanded(
                  child: Text(
                    " ${widget.post.date}",
                    style: kTextPopR14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.access_time_rounded),
                const SizedBox(width: 5),
                Text('Time: ', style: kTextPopB14),
                Expanded(
                  child: Text(
                    " ${widget.post.time}",
                    style: kTextPopR14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 5),
                Text('Category: ', style: kTextPopB14),
                Text(widget.post.category, style: kTextPopR14)
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 10.0),
                applyStatus == "Expired"
                    ? const Expanded(
                        child: OutlinedButton(
                          onPressed: null,
                          child: Text(
                            "View Details",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      )
                    : Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) => ViewDetails(
                                    pid: widget.post.id,
                                    ngoname: widget.post.ngoname,
                                    ngocity: widget.post.ncity,
                                    drivecity: widget.post.city,
                                    driveaddress: widget.post.address,
                                    driveDate: widget.post.date,
                                    applyStatus: widget.applyStatus,
                                    userType: widget.userType,
                                    category: widget.post.category,
                                    driveTime: widget.post.time,
                                    title: widget.post.driveTitle,
                                    desc: widget.post.description,
                                  ),
                                ),
                              );
                            },
                            child: const Text("View Details")),
                      ),
                const SizedBox(width: 10.0),
                applyStatus == "Expired"
                    ? Expanded(
                        child: ElevatedButton(
                          onPressed: null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black54),
                          ),
                          child: const Text(
                            'Expired',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : Expanded(
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: () {
                                  if (widget.applyStatus != "Applied" &&
                                      widget.applyStatus != "YOUR POST") {
                                    applyPost();
                                    setState(() {
                                      _isApply = false;
                                      _isLoading = true;
                                    });
                                  }
                                },
                                child: Text(
                                  _isApply ? widget.applyStatus : 'Applied',
                                ),
                              ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
