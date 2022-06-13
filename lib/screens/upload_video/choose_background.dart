import 'package:flutter/material.dart';

class ChooseBackground extends StatelessWidget {
  const ChooseBackground({Key? key}) : super(key: key);

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
