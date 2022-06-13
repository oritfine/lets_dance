import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

import 'choose_background.dart';

class BrowseVideo extends StatefulWidget {
  //const Video({Key? key}) : super(key: key);

  @override
  _BrowseVideoState createState() => _BrowseVideoState();
}

class _BrowseVideoState extends State<BrowseVideo> {
  late VideoPlayerController _videoPlayerController;
  File? _video;
  final picker = ImagePicker();
  bool isNextActive = false;

  _pickVideo() async {
    final video = await picker.pickVideo(source: ImageSource.gallery);
    if (video == null) {
      print('video is null');
      return;
    }
    _video = File(video.path);
    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {
          isNextActive = true;
        });
        //_videoPlayerController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('upload your video'),
        ),
        body: Column(
          children: [
            _video == null
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 100, top: 30, right: 100),
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400]),
                          child: Text('Upload New Video',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            _pickVideo();
                          },
                        ),
                        SizedBox(height: 40),
                        Icon(Icons.photo, size: 200),
                      ],
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 30, right: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400]),
                          child: Text('Upload New Video',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            _pickVideo();
                          },
                        ),
                        SizedBox(height: 40),
                        _videoPlayerController.value.isInitialized
                            ? AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: Stack(
                                  children: [
                                    VideoPlayer(_videoPlayerController),
                                    Align(
                                      alignment: Alignment.center,
                                      child: FloatingActionButton(
                                        backgroundColor:
                                            Colors.white.withOpacity(0.0),
                                        onPressed: () {
                                          // Wrap the play or pause in a call to `setState`. This ensures the
                                          // correct icon is shown.
                                          setState(() {
                                            // If the video is playing, pause it.
                                            if (_videoPlayerController
                                                .value.isPlaying) {
                                              _videoPlayerController.pause();
                                            } else {
                                              // If the video is paused, play it.
                                              _videoPlayerController.play();
                                            }
                                          });
                                        },
                                        // Display the correct icon depending on the state of the player.
                                        child: Icon(
                                          color: Colors.grey[400]
                                              ?.withOpacity(0.7),
                                          size: 65,
                                          _videoPlayerController.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
            SizedBox(height: 230),
            Padding(
              padding: EdgeInsets.only(left: 250),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                  onPressed: isNextActive
                      ? () {
                          print('orit' + isNextActive.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseBackground()));
                        }
                      : null),
            ),
          ],
        ));
  }
}
