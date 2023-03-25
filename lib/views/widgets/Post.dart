import 'package:aikyam/models/post.dart';
import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/views/widgets/viewPostDetailsScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NgoProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
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
                                )));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      color: Colors.grey,
                      child: Image.asset('assets/images/dp.jpg'),
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
                          style: kTextPopM16,
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
                  onTap: () {},
                  child: const Icon(
                    Icons.share,
                    size: 32.0,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'This is title of the ngo drive its a little bit big tittle its a little bit big tittler',
              style: kTextPopM16,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.location_city),
                const SizedBox(width: 5),
                Text('City: ', style: kTextPopB14),
                Text(widget.post.city, style: kTextPopR14)
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.access_time_rounded),
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
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 5),
                Text('Category: ', style: kTextPopB14),
                Text(widget.post.category, style: kTextPopR14)
              ],
            ),
            SizedBox(height: 5),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
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
                            ),
                          ),
                        );
                      },
                      child: const Text("View")),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            applyPost();
                            setState(() {
                              _isApply = false;
                              _isLoading = true;
                            });
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
