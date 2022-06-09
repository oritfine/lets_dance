import 'package:flutter/material.dart';

class MyVideos extends StatelessWidget {
  const MyVideos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Videos'),
        centerTitle: true,
      ),
    );
  }
}
