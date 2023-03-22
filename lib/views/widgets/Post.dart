import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/views/widgets/viewPostDetailsScreen.dart';
import 'package:aikyam/views/Screens/User/NgoProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
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

  const PostItem({
    required this.ngoname,
    required this.ngocity,
    required this.drivecity,
    required this.driveaddress,
    required this.driveDate,
    required this.applyStatus,
    required this.pid,
    required this.userType,
  });

  @override
  State<PostItem> createState() => _PostState();
}

class _PostState extends State<PostItem> {
  bool _isExpanded = true;
  bool _isLike = true;
  bool _isApply = true;
  bool _isLoading = false;

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void toggleLike() {
    setState(() {
      _isLike = !_isLike;
    });
  }

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
    final PageController _pageController = PageController(initialPage: 0);

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
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      color: const Color(0xffFF0E58),
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
            const SizedBox(
              height: 5
            ),
            Row(
              children: [
                const Icon(Icons.location_city),
                const SizedBox(width: 5),
                Text('City: ', style: kTextPopB14),
                Text('Pune', style: kTextPopR14)
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
                    '19 Mar ',
                    style: kTextPopR14,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 5),
                Text('Category: ', style: kTextPopB14),
                Text('Education', style: kTextPopR14)
              ],
            ),
            SizedBox(height: 5),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                      label: Text('123')),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewDetails()));
                      },
                      child: const Text("view")),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: _isLoading ? const CircularProgressIndicator() : ElevatedButton(
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
