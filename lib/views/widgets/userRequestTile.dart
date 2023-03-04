import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String name;
  final String city;
  final String imageUrl;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  ProfileTile({
    required this.name,
    required this.city,
    required this.imageUrl,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.green, width: 2),
      ),
      color: ksecondaryColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
        ),
        title: Text(name),
        subtitle: Text(city),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
              onPressed: onAccept,
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: onReject,
            ),
          ],
        ),
      ),
    );
  }
}
