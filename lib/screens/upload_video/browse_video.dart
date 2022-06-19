import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'choose_background.dart';
import 'dart:convert';

class BrowseVideo extends StatefulWidget {
  //const BrowseVideo({Key? key}) : super(key: key);
  final String uid;
  final String username;

  const BrowseVideo({super.key, required this.uid, required this.username});

  @override
  _BrowseVideoState createState() => _BrowseVideoState();
}

class _BrowseVideoState extends State<BrowseVideo> {
  late VideoPlayerController _videoPlayerController;
  File? _video;
  final picker = ImagePicker();
  bool isNextActive = false;
  String serverUrl = '';

  // String get url {
  //   return serverUrl;
  // }

  // void _sendVideo(File video) async {
  //   var dio = Dio();
  //   String fileName = video.path.split('/').last;
  //   FormData formData = FormData.fromMap({
  //     "file": await MultipartFile.fromFile(video.path, filename: fileName),
  //   });
  //   var response = await dio.post('http://172.20.1.109:80/upload');
  //   print(response);
  //   return response.data['id'];
  //   // FormData formData = FormData.fromMap({
  //   //   "name": "wendux",
  //   //   "file1": MultipartFile(video, "upload1.jpg")
  //   // });
  //   // response = await dio.post("/info", data: formData)
  // }

  void _uploadFileToServer(File video) async {
    String serverUrl = '';
    var request = http.MultipartRequest(
        "POST", Uri.parse('http://172.20.1.109:8080/upload'));
    request.files.add(await http.MultipartFile.fromPath('video', video.path));

    print(request);
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          print(response);
          setState(() {
            serverUrl = json.decode(onValue.body)['url'];
          });
          //serverUrl = json.decode(onValue.body)['url'];
          print('response from server: ' + serverUrl);
          final String url = json.decode(onValue.body)['url'];
        } catch (e) {
          print(e);
          //Todo show message - upload your video again
        }
      });
    });
    //return serverUrl;
  }

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
          title: Text('Upload New Video'),
        ),
        body: Column(
          children: [
            _video == null
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 100, top: 30, right: 100),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400]),
                          child: Text('Browse',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            _pickVideo();
                          },
                        ),
                        const SizedBox(height: 40),
                        Icon(Icons.photo, size: 200),
                        const SizedBox(height: 250),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 160, top: 30, right: 150),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400]),
                          child: Text('Browse',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            _pickVideo();
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        height: 400,
                        width: 240,
                        child: _videoPlayerController.value.isInitialized
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
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
            Padding(
              padding: EdgeInsets.only(left: 250),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                  onPressed: isNextActive
                      ? () async {
                          _uploadFileToServer(_video!);
                          //_sendVideo(_video!);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseBackground(
                                        videoPlayerController:
                                            _videoPlayerController,
                                        serverUrl: serverUrl,
                                        uid: widget.uid,
                                        username: widget.username,
                                      )));
                        }
                      : null),
            ),
          ],
        ));
  }
}
