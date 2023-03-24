import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/Screens/Login/Login.dart';
import 'package:aikyam/views/Screens/User/NgoProfileScreen.dart';
import 'package:aikyam/views/Screens/User/UserProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAppdrawer extends StatefulWidget {
  const UserAppdrawer({super.key});

  @override
  State<UserAppdrawer> createState() => _UserAppdrawerState();
}

class _UserAppdrawerState extends State<UserAppdrawer> {
  var pp = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setProfilePic();
  }

  void setProfilePic() {
    pp = Provider.of<Auth>(context, listen: false).profilePic;
    print(pp);
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
                      : const AssetImage('assets/images/dp.jpg'),
                ),
                Text(
                  'Dip Hire',
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
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text(' Categories'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NgoProfile(),
                ),
              );
            },
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

class NgoAppdrawer extends StatefulWidget {
  const NgoAppdrawer({super.key});

  @override
  State<NgoAppdrawer> createState() => _NgoAppdrawerState();
}

class _NgoAppdrawerState extends State<NgoAppdrawer> {
  var pp = "";
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setProfilePic();
  }

  void setProfilePic() async {
    pp = Provider.of<Auth>(context, listen: false).profilePic;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Smile Foundation",
              style: kTextPopB16,
            ),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NgoProfile(),
                    ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                    height: 70.0,
                    width: 70.0,
                    color: const Color(0xffFF0E58),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: pp.isNotEmpty
                          ? Image.network(pp).image
                          : const AssetImage('assets/images/dp.jpg'),
                    )),
              ),
            ),
            accountEmail: null,
          ),
          // DrawerHeader(
          //   decoration: const BoxDecoration(
          //     color: Color(0xfff1BB273),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ClipRRect(
          //         borderRadius: BorderRadius.circular(10.0),
          //         child: Container(
          //           height: 70.0,
          //           width: 70.0,
          //           color: const Color(0xffFF0E58),
          //           child: Image.asset('assets/images/dp.jpg'),
          //         ),
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Smile Foundation',
          //             style: kTextPopM16.copyWith(color: ksecondaryColor),
          //           ),
          //           Flexible(
          //             child: Text(
          //               'What should we write here ',
          //               overflow: TextOverflow.ellipsis,
          //               maxLines: 10,
          //               style: kTextPopR12.copyWith(color: ksecondaryColor),
          //             ),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NgoProfile()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('help and support'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).signOut();
              Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(builder: (context) => new LogIn()));
            },
          ),
        ],
      ),
    );
  }
}
