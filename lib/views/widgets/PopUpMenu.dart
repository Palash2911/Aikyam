import 'package:flutter/material.dart';


class dotmenu extends StatelessWidget {
  const dotmenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconSize: 30,
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: Text("Share Post"),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Text("View insights"),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Text("Edit Post"),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 0) {
          // Share Post
        } else if (value == 1) {
          // sta
        } else if (value == 2) {}
      },
    );
  }
}
