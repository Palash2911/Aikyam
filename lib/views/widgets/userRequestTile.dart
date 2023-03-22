import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ProfileTile extends StatefulWidget {
  final String name;
  final String city;
  final String imageUrl;

  ProfileTile({
    required this.name,
    required this.city,
    required this.imageUrl,
  });

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
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
          backgroundImage: Image.network(widget.imageUrl).image,
        ),
        title: Text(widget.name),
        subtitle: Text(widget.city),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
