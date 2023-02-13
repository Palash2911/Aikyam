import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hello"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Text("Hello"),
      ),
    );
  }
}
