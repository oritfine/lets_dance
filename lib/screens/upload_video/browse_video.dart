import 'package:flutter/material.dart';

// class chooseVideo extends StatefulWidget {
//   //const chooseVideo({Key? key}) : super(key: key);
//
//   @override
//   _chooseVideoState createState() => _chooseVideoState();
// }
//
// class _chooseVideoState extends State<chooseVideo> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class BrowseVideo extends StatelessWidget {
  const BrowseVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Video'),
        centerTitle: true,
      ),
    );
  }
}
