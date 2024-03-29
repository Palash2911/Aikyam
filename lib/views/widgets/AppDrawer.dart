import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Login/Login.dart';
import 'package:aikyam/views/Screens/Ngo/NgoProfileScreen.dart';
import 'package:aikyam/views/Screens/User/UserProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserAppdrawer extends StatefulWidget {
  const UserAppdrawer({super.key});

  @override
  State<UserAppdrawer> createState() => _UserAppdrawerState();
}

class _UserAppdrawerState extends State<UserAppdrawer> {
  var pp = "";
  var name = "";
  var authToken = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setProfilePic();
  }

  void setProfilePic() async {
    var authProvider = Provider.of<Auth>(context, listen: false);
    pp = authProvider.profilePic;
    name = authProvider.uName;
    authToken = authProvider.token;
    setState(() {});
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(
        "https://docs.google.com/forms/d/e/1FAIpQLSeTFJ_-ezuk-eTapWJxRtkfW_DDPOfYcwltPNTqCUadkZ9NxA/viewform"))) {
      throw Exception('Could not launch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xfff1BB273),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: pp.isNotEmpty
                      ? Image.network(pp).image
                      : const AssetImage('assets/images/user.png'),
                ),
                Text(
                  name,
                  style: kTextPopM16.copyWith(color: ksecondaryColor),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(
                    isUser: true,
                    authToken: authToken,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('help and support'),
            onTap: _launchUrl,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Fluttertoast.showToast(
                msg: " Thank You For Choosing Aikyam",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: kprimaryColor,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Provider.of<Auth>(context, listen: false).signOut().then((value) {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (context) => LogIn()));
              });
            },
          ),
        ],
      ),
    );
  }
}

class NgoAppdrawer extends StatefulWidget {
  const NgoAppdrawer({super.key});

  @override
  State<NgoAppdrawer> createState() => _NgoAppdrawerState();
}

class _NgoAppdrawerState extends State<NgoAppdrawer> {
  var pp = "";
  var name = "";
  var authToken = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setFields();
  }

  void setFields() async {
    var authProvider = Provider.of<Auth>(context, listen: false);
    pp = authProvider.profilePic;
    name = authProvider.uName;
    authToken = authProvider.token;
    setState(() {});
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(
        "https://docs.google.com/forms/d/e/1FAIpQLSeTFJ_-ezuk-eTapWJxRtkfW_DDPOfYcwltPNTqCUadkZ9NxA/viewform"))) {
      throw Exception('Could not launch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              name,
              style: kTextPopB16,
            ),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NgoProfile(
                      authToken: authToken,
                      isUser: true,
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: pp.isNotEmpty
                        ? Image.network(pp).image
                        : const AssetImage('assets/images/ngo.png'),
                  ),
                ],
              ),
            ),
            accountEmail: null,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NgoProfile(
                          authToken: authToken,
                          isUser: true,
                        )),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help And Support'),
            onTap: _launchUrl,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).signOut();
              Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(builder: (context) => LogIn()));
            },
          ),
        ],
      ),
    );
  }
}
