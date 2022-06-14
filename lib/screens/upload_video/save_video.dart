import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SaveVideo extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final String backgroundName;
  final String faceName;

  SaveVideo(
      {required this.videoPlayerController,
      required this.backgroundName,
      required this.faceName});

  @override
  _SaveVideoState createState() => _SaveVideoState();
}

class _SaveVideoState extends State<SaveVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Video'),
        centerTitle: true,
      ),
    );
  }
}
