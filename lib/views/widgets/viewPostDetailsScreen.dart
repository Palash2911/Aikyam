import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewDetails extends StatefulWidget {
  final String ngoname;
  final String ngocity;
  final String drivecity;
  final String driveaddress;
  final String driveDate;
  final String applyStatus;
  final String pid;
  final String userType;
  final String driveTime;
  final String title;
  final String desc;
  final String category;

  const ViewDetails({
    super.key,
    required this.pid,
    required this.ngoname,
    required this.ngocity,
    required this.drivecity,
    required this.driveaddress,
    required this.driveDate,
    required this.applyStatus,
    required this.userType,
    required this.category,
    required this.driveTime,
    required this.title,
    required this.desc,
  });

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  List<dynamic> _imgPost = [];
  String? noVol;
  String? loc;
  var _isLoading = true;
  bool _isApply = true;
  var _isApplyLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchDetails();
  }

  void _fetchDetails() async {
    var post =
        await Provider.of<PostProvider>(context).getPostDetails(widget.pid);
    noVol = post!.noofVolunters.toString();
    loc = post.address.toString();
    _imgPost = post.photos;
    setState(() {
      _isLoading = false;
    });
  }

  Future applyPost() async {
    if (_isApply && widget.applyStatus == "Apply") {
      var postProvider = Provider.of<PostProvider>(context, listen: false);
      await postProvider.applyPost(widget.pid, widget.userType).then((value) {
        setState(() {
          _isApplyLoading = false;
        });
      });
    } else {
      setState(() {
        _isApplyLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Details"),
      ),
      body: _isLoading
          ? Center(
              child: SizedBox(
                height: 200.0,
                child: Image.asset(
                  'assets/images/loading.gif',
                  fit: BoxFit.contain,
                ),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset('assets/images/ngo.png'),
                            ),
                            title: Text(
                              widget.ngoname,
                              style: kTextPopM16,
                            ),
                            subtitle: const Text('More Info'),
                          ),
                          const Divider(),
                          Text(
                            widget.title,
                            style: kTextPopM16,
                          ),
                          const SizedBox(height: 12.0),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kpostColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.driveDate,
                                      style: kTextPopM16,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.watch_later_outlined),
                                    Text(
                                      widget.driveTime,
                                      style: kTextPopM16,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider(),
                          const SizedBox(width: 12.0),
                          Container(
                            height: 250,
                            color: Colors.grey[300],
                            child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _imgPost.length,
                                itemBuilder: ((context, index) {
                                  return Image.network(_imgPost[index]);
                                })),
                          ),
                          const SizedBox(height: 16),
                          Text(widget.desc, style: kTextPopR16),
                          const SizedBox(width: 12.0),
                          const Divider(),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: kpostColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 5),
                                Text("$noVol Volunteers Required",
                                    style: kTextPopB14),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: kpostColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.location_city),
                                    const SizedBox(width: 5),
                                    Text('City: ', style: kTextPopB14),
                                    Text(widget.ngocity, style: kTextPopR14)
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(width: 5),
                                    Text('Drive Location: ',
                                        style: kTextPopB14),
                                    Expanded(
                                      child: Text(
                                        loc.toString(),
                                        style: kTextPopR14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.category),
                                    const SizedBox(width: 5),
                                    Text('Drive category: ',
                                        style: kTextPopB14),
                                    Expanded(
                                      child: Text(
                                        widget.category,
                                        style: kTextPopR14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(9.0),
                            child: _isApplyLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ElevatedButton(
                                    onPressed: () {
                                      if (widget.applyStatus != "Applied" &&
                                          widget.applyStatus != "YOUR POST") {
                                        applyPost();
                                        setState(() {
                                          _isApply = false;
                                          _isApplyLoading = true;
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
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
