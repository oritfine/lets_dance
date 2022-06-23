import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_dance/screens/my_videos.dart';
import 'package:lets_dance/shared/consts_objects/loading.dart';
import 'package:http/http.dart' as http;

import '../../models/video.dart';
import '../../services/database.dart';
import '../../shared/consts_objects/buttons.dart';
import '../../shared/consts_objects/video_object.dart';
import '../../shared/designs.dart';
import '../home/home.dart';

class SaveVideo extends StatefulWidget {
  final String url;
  final String uid;

  SaveVideo({
    required this.url,
    required this.uid,
  });

  @override
  _SaveVideoState createState() => _SaveVideoState();
}

class _SaveVideoState extends State<SaveVideo> {
  // bool controller_initialized = false;
  // VideoPlayerController videoPlayerController =
  // VideoPlayerController.network(widget.url)
  //   ..initialize().then((_) {
  //     setState(() {
  //       controller_initialized = true;
  //     });
  //   });

  String videoName = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final DatabaseService _db = DatabaseService();

  void saveInDB() async {
    String video_id = '';
    try {
      // adding video to videos collection
      video_id =
          await _db.addVideo(videoName, widget.url, widget.uid) as String;
      // adding video to videos list of user in users collection
      await _db.addVideoToUserVideosList(widget.uid, video_id);
      print(widget.uid);
      print(video_id);
    } catch (e) {
      if (video_id == '') {
        print('Error in adding video to videos collection');
      } else {
        print('Error in adding video to user videos in users collection');
      }
      print(e);
      setState(() {
        error = "Error saving your video. Please try again";
      });
      // if (result == null) {
      //   setState(() {
      //     error = 'could not save video';
      //     loading = false;
      //   });
    }
  }

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
            resizeToAvoidBottomInset: false,
            backgroundColor: background_color,
            appBar: AppBarDesign(text: 'Save Video'),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    child: VideoWidget(
                      uid: widget.uid,
                      url: widget.url,
                      play: true,
                      showDetails: false,
                      // showName: false,
                      // showLikes: false,
                      // isLiked: false,
                      video: Video(
                          video_id: "",
                          user_id: widget.uid,
                          url: widget.url,
                          likers: [],
                          likes: 0,
                          name: 'tmp'),
                    ),
                  ),
                  // ? AspectRatio(
                  //     aspectRatio: videoPlayerController.value.aspectRatio,
                  //     child: Stack(
                  //       children: [
                  //         VideoPlayer(videoPlayerController),
                  //         Align(
                  //           alignment: Alignment.center,
                  //           child: FloatingActionButton(
                  //             backgroundColor:
                  //                 Colors.white.withOpacity(0.0),
                  //             onPressed: () {
                  //               // Wrap the play or pause in a call to `setState`. This ensures the
                  //               // correct icon is shown.
                  //               setState(() {
                  //                 // If the video is playing, pause it.
                  //                 if (videoPlayerController
                  //                     .value.isPlaying) {
                  //                   videoPlayerController.pause();
                  //                 } else {
                  //                   // If the video is paused, play it.
                  //                   videoPlayerController.play();
                  //                 }
                  //               });
                  //             },
                  //             // Display the correct icon depending on the state of the player.
                  //             child: Icon(
                  //               color: Colors.grey[400]?.withOpacity(0.7),
                  //               size: 65,
                  //               videoPlayerController.value.isPlaying
                  //                   ? Icons.pause
                  //                   : Icons.play_circle,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //: Container(),
                  SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            decoration:
                                textFormDecoration.copyWith(hintText: 'Name'),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter video name' : null,
                            onChanged: (val) {
                              setState(() => videoName = val);
                            }),
                        SizedBox(height: 20.0),
//                         Button(
//                             text: 'Save Video',
//                             color: appbar_color,
//                             isAsync: true,
//                             onPressed: () async {
//                               if (_formKey.currentState!.validate()) {
//                                 setState(() => loading = true);
// //                                = await _sendDataToServer();
//                                 await Future.delayed(Duration(seconds: 5));
//
//                                 saveInDB();
//                                 setState(() {
//                                   loading = false;
//                                 });
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Home()));
//                               }
//                             }),
                        ElevatedButton(
                            style: buttonStyle,
                            child: TextDesign(text: 'Save Video', size: 18),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
//                                = await _sendDataToServer();
                                await Future.delayed(Duration(seconds: 5));

                                saveInDB();
                                setState(() {
                                  loading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              }
                            }),
                        SizedBox(height: 20),
                        // Button(
                        //     text: 'Cancel',
                        //     color: disabled_next_color,
                        //     isAsync: false,
                        //     onPressed: () {
                        //       print('cancel');
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => Home()));
                        //       //builder: (context) => MyVideos(uid: uid, videos: videos)));
                        //     }),
                        ElevatedButton(
                          style: disabledButtonStyle,
                          child: TextDesign(text: 'Cancel', size: 18),
                          onPressed: () {
                            print('cancel');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                            //builder: (context) => MyVideos(uid: uid, videos: videos)));
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
