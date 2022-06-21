import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lets_dance/shared/consts_objects/floating_play_button.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'choose_background.dart';
import 'dart:convert';
import '../../shared/designs.dart';

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
    var request = http.MultipartRequest(
        "POST", Uri.parse('http://172.20.1.109:8080/upload'));
    request.files.add(await http.MultipartFile.fromPath('video', video.path));

    print(request);
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          print(response);
          // setState(() {
          //   serverUrl = json.decode(onValue.body)['url'];
          // });
          //serverUrl = json.decode(onValue.body)['url'];
          //print('response from server: ' + serverUrl);
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
        backgroundColor: background_color,
        appBar: AppBarDesign(text: 'Upload New Video'),
        body: Column(
          children: [
            const SizedBox(height: 20.0),
            _video == null
                ? Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 150, top: 20, right: 150),
                        child: ElevatedButton(
                          style: button_style,
                          child: TextDesign(text: 'Browse', size: 18),
                          onPressed: () {
                            _pickVideo();
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Column(
                          children: [
                            SizedBox(height: 1),
                            Icon(
                              Icons.add_a_photo,
                              size: 160,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 150, top: 20, right: 150),
                        child: ElevatedButton(
                          style: button_style,
                          child: TextDesign(text: 'Browse', size: 18),
                          onPressed: () {
                            _pickVideo();
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: _videoPlayerController.value.isInitialized
                            ? AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: Stack(
                                  children: [
                                    VideoPlayer(_videoPlayerController),
                                    FloatingPlayButton(
                                        controller: _videoPlayerController),
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
                  style: isNextActive ? button_style : disabled_next_style,
                  child: TextDesign(text: 'Next', size: 18),
                  onPressed: isNextActive
                      ? () {
                          //_uploadFileToServer(_video!);
                          //_sendVideo(_video!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseBackground(
                                        video: _video!,
                                        uid: widget.uid,
                                        username: widget.username,
                                      )));
                        }
                      : () {}),
            ),
          ],
        ));
  }
}
