import 'package:flutter/material.dart';
import 'package:lets_dance/shared/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:lets_dance/shared/loading.dart';

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
  String videoName = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Save Video'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  widget.videoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio:
                              widget.videoPlayerController.value.aspectRatio,
                          child: Stack(
                            children: [
                              VideoPlayer(widget.videoPlayerController),
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
                                      if (widget.videoPlayerController.value
                                          .isPlaying) {
                                        widget.videoPlayerController.pause();
                                      } else {
                                        // If the video is paused, play it.
                                        widget.videoPlayerController.play();
                                      }
                                    });
                                  },
                                  // Display the correct icon depending on the state of the player.
                                  child: Icon(
                                    color: Colors.grey[400]?.withOpacity(0.7),
                                    size: 65,
                                    widget.videoPlayerController.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Name'),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter video name' : null,
                            onChanged: (val) {
                              setState(() => videoName = val);
                            }),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400]),
                          child: Text('Save Video',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              // dynamic result = await _auth
                              //     .signInWithEmailAndPassword(email, password);
                              dynamic result = 1;
                              if (result == null) {
                                setState(() {
                                  error = 'could not save video';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        error == ''
                            ? Container()
                            : Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
