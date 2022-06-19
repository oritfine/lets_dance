import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lets_dance/shared/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:lets_dance/shared/loading.dart';
import 'package:http/http.dart' as http;

import '../../services/database.dart';

class SaveVideo extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final String backgroundName;
  final String avatarName;
  final String faceName;
  final String uid;

  SaveVideo(
      {required this.videoPlayerController,
      required this.backgroundName,
      required this.avatarName,
      required this.faceName,
      required this.uid});

  @override
  _SaveVideoState createState() => _SaveVideoState();
}

class _SaveVideoState extends State<SaveVideo> {
  String videoName = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final DatabaseService _db = DatabaseService();

  Future<bool> _sendDataToServer() async {
    var request = http.MultipartRequest(
        "POST", Uri.parse('http://172.20.1.109:8080/saveName'));
    request.fields['video_name'] = videoName;
    print(request);
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) async {
        //TODO return response status
        // try {
        //   response.stream.listen((newBytes) {
        //     bytes.addAll(newBytes);
        //   });
        //   Future<File> video = File('/video.mp4').writeAsBytes(bytes);
        //   print(response);
        //
        //   print('hi');
        //   // get your response here...
        // } catch (e) {
        //   print(e);
        //   //Todo show message - upload your video again
      });
    });
    return true;
  }

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
//                              setState(() => loading = true);
                              bool succeeded = await _sendDataToServer();
                              if (!succeeded) {
                                //                              setState(() => loading = false);
                                // TODO popup message of error saving in server
                              } else {
                                String video_id = await _db.addVideo(
                                    'video_tmp',
                                    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                                    widget.uid) as String;
                                succeeded = await _db.addVideoToUserVideosList(
                                    widget.uid, video_id);
                              }
                              if (!succeeded) {
                                // TODO popup message of error saving in db
                              }
                              // if (result == null) {
                              //   setState(() {
                              //     error = 'could not save video';
                              //     loading = false;
                              //   });
                              // }
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
