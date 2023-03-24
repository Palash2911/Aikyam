import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/views/widgets/viewPostDetailsScreen.dart';
import 'package:aikyam/views/Screens/Ngo/NgoProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostItem extends StatefulWidget {
  final String ngoname;
  final String ngocity;
  final String drivecity;
  final String driveaddress;
  final String driveDate;
  final String applyStatus;
  final String pid;
  final String userType;
  final String driveTime;
  final String category;
  final String driveTitle;

  const PostItem({
    required this.ngoname,
    required this.ngocity,
    required this.drivecity,
    required this.driveaddress,
    required this.driveDate,
    required this.applyStatus,
    required this.pid,
    required this.userType,
    required this.driveTime,
    required this.category,
    required this.driveTitle,
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
      await postProvider.applyPost(widget.pid, widget.userType).then((value) {
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NgoProfile()));
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
                          widget.ngoname,
                          style: kTextPopM16,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.ngocity, style: kTextPopR14),
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
                Text(widget.drivecity, style: kTextPopR14)
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.access_time_rounded),
                const SizedBox(width: 5),
                Text('Date and Time: ', style: kTextPopB14),
                Expanded(
                  child: Text(
                    "${widget.driveDate}, ${widget.driveTime}",
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
                Text(widget.category, style: kTextPopR14)
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
                              pid: widget.pid,
                              ngoname: widget.ngoname,
                              ngocity: widget.ngocity,
                              drivecity: widget.drivecity,
                              driveaddress: widget.driveaddress,
                              driveDate: widget.driveDate,
                              applyStatus: widget.applyStatus,
                              userType: widget.userType,
                              category: widget.category,
                              driveTime: widget.driveTime,
                            ),
                          ),
                        );
                      },
                      child: const Text("View")),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: _isLoading
                      ? const CircularProgressIndicator()
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
