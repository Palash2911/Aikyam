import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/views/Screens/Ngo/NgoProfileScreen.dart';
import 'package:aikyam/views/Screens/User/UserProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProfileTile extends StatefulWidget {
  final String name;
  final String city;
  final String imageUrl;
  final String uid;
  final String pid;
  final String applicationStatus;
  final String userType;

  ProfileTile({
    required this.name,
    required this.city,
    required this.imageUrl,
    required this.uid,
    required this.pid,
    required this.applicationStatus,
    required this.userType,
  });

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  var isLoading = false;
  var accepted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    accepted = widget.applicationStatus == "InProcess" ? false : true;
  }

  void applyReject(String ar) async {
    if (ar == "Accept") {
      await Provider.of<PostProvider>(context, listen: false)
          .acceptRejectUser("Accept", widget.pid, widget.uid)
          .then((value) {
        Fluttertoast.showToast(
          msg: "Accepted !",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          accepted = true;
          isLoading = false;
        });
      });
    } else {
      await Provider.of<PostProvider>(context, listen: false)
          .acceptRejectUser("Reject", widget.pid, widget.uid)
          .then((value) {
        Fluttertoast.showToast(
          msg: "Rejected !",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          accepted = true;
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(color: Colors.green, width: 2),
      ),
      color: ksecondaryColor,
      child: ListTile(
        leading: InkWell(
          onTap: () {
            if (widget.userType != "Ngo") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(
                    authToken: widget.uid,
                    isUser: false,
                  ),
                ),
              );
            }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NgoProfile(
                    authToken: widget.uid,
                    isUser: false,
                  ),
                ),
              );
            }
          },
          child: CircleAvatar(
            backgroundImage: Image.network(widget.imageUrl).image,
          ),
        ),
        title: InkWell(
          onTap: () {
            if (widget.userType != "Ngo") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(
                    authToken: widget.uid,
                    isUser: false,
                  ),
                ),
              );
            }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NgoProfile(
                    authToken: widget.uid,
                    isUser: false,
                  ),
                ),
              );
            }
          },
          child: Text(widget.name),
        ),
        subtitle: Text(widget.city),
        trailing: isLoading
            ? const CircularProgressIndicator()
            : accepted
                ? Text(widget.applicationStatus)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          applyReject("Accept");
                          setState(() {
                            isLoading = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          applyReject("Reject");
                          setState(() {
                            isLoading = true;
                          });
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
