import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lets_dance/screens/upload_video/face_tile.dart';
import 'package:lets_dance/screens/upload_video/save_video.dart';
import 'package:lets_dance/shared/consts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lets_dance/services/storage.dart';
import 'package:http/http.dart' as http;

import '../../services/database.dart';
import '../../shared/consts_objects/loading.dart';
import '../../shared/designs.dart';

class ChooseFace extends StatefulWidget {
  final String uid;
  final String username;
  final File video;
  final String backgroundName;
  final String avatarName;

  ChooseFace(
      {required this.uid,
      required this.username,
      required this.video,
      required this.backgroundName,
      required this.avatarName});

  @override
  _ChooseFaceState createState() => _ChooseFaceState();
}

class _ChooseFaceState extends State<ChooseFace> {
  final DatabaseService _db = DatabaseService();
  late final String nameInServer;
  bool loading = false;
  bool isNextActive = false;
  int selectedIndex = -1;
  final Storage storage = Storage();

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
      isNextActive = true;
    });
  }

  Future<void> _sendDataToServer() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String video_name = '${widget.username}_${timestamp}.mp4';
    String emoji = facesNames[selectedIndex];
    if (selectedIndex == 0) {
      emoji = 'None';
    }

    var request =
        http.MultipartRequest("POST", Uri.parse(upload_and_process_url));
    request.fields['url'] = video_name;
    request.fields['background'] = widget.backgroundName;
    request.fields['emoji'] = emoji;
    request.fields['color_pallette'] = widget.avatarName;
    request.files
        .add(await http.MultipartFile.fromPath('video', widget.video.path));
    print(request);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        setState(() {
          nameInServer = video_name;
        });
        // try {
        //   //var file = await File('/video.mp4').create(/*recrusive: true*/);
        //   var bytes = <int>[];
        //   await response.stream.listen((newBytes) {
        //     print('entered to listen');
        //     bytes.addAll(newBytes);
        //     Future<File> video = File('/video_success.mp4').writeAsBytes(bytes);
        //   });
      }
    } catch (e) {
      print(e);
      //TODO show error
    }
    //request.send().then((response) {
    //http.Response.fromStream(response).then((onValue) async {

    //   response.stream.listen{
    //         (newBytes) {
    //       bytes.addAll(newBytes);
    //     },
    // onDone: () async{
    // await file.writeAsBytes(bytes);
    // }
    //print(response);
    // setState(() {
    //   widget.videoPlayerController =
    //       VideoPlayerController.file(onValue.body);
    // });

    //print('hi');
    // get your response here...
    // } catch (e) {
    //
    //   //Todo show message - upload your video again
    // }
    //});
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBarDesign(text: 'Choose Emoji'),
      body: loading
          ? Loading()
          : Padding(
              padding: EdgeInsets.only(left: 30, top: 20, right: 30),
              child: Column(
                children: [
                  // check that the video is passed:
                  // widget.videoPlayerController.value.isInitialized
                  //     ? AspectRatio(
                  //         aspectRatio: widget.videoPlayerController.value.aspectRatio,
                  //         child: Stack(
                  //           children: [
                  //             VideoPlayer(widget.videoPlayerController),
                  //             Align(
                  //               alignment: Alignment.center,
                  //               child: FloatingActionButton(
                  //                 backgroundColor: Colors.white.withOpacity(0.0),
                  //                 onPressed: () {
                  //                   // Wrap the play or pause in a call to `setState`. This ensures the
                  //                   // correct icon is shown.
                  //                   setState(() {
                  //                     // If the video is playing, pause it.
                  //                     if (widget
                  //                         .videoPlayerController.value.isPlaying) {
                  //                       widget.videoPlayerController.pause();
                  //                     } else {
                  //                       // If the video is paused, play it.
                  //                       widget.videoPlayerController.play();
                  //                     }
                  //                   });
                  //                 },
                  //                 // Display the correct icon depending on the state of the player.
                  //                 child: Icon(
                  //                   color: Colors.grey[400]?.withOpacity(0.7),
                  //                   size: 65,
                  //                   widget.videoPlayerController.value.isPlaying
                  //                       ? Icons.pause
                  //                       : Icons.play_circle,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     : Container(),
                  //
                  TextDesign(text: choose_emoji_text, size: 18),
                  SizedBox(height: 18),
                  // Container(
                  //   height: 500,
                  //   width: 400,
                  //   child: GridView.builder(
                  //     itemCount: 52,
                  //     itemBuilder: (context, index) {
                  //       return BackgroundTile(
                  //         backgroundPath: 'images/background_images/$index.jpg',
                  //       );
                  //       // return Container(
                  //       //   padding: const EdgeInsets.only(left: 5, right: 5),
                  //       //   //elevation: 10,
                  //       //   child: Center(
                  //       //     child: Image.asset(
                  //       //       values[index],
                  //       //       //fit: BoxFit.fill,
                  //       //     ),
                  //       //   ),
                  //       // );
                  //     },
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2),
                  //   ),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.69,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: GridView.count(
                      primary: false,
                      //padding: const EdgeInsets.all(400),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 15,
                      crossAxisCount: 3,
                      childAspectRatio: (70.0 / 95.0),
                      children: [
                        for (int i = 0; i < 28; i++)
                          FaceTile(
                            facePath: get_image_path('emoji', facesNames[i]),
                            onTap: () => selectIndex(i),
                            selected: i == selectedIndex,
                            faceName: facesNames[i],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: isNextActive ? button_style : disabled_next_style,
                      child: TextDesign(
                          text: 'Generate your Lets-Dance video!', size: 18),
                      onPressed: isNextActive
                          ? () async {
                              await _sendDataToServer();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SaveVideo(
                                            url:
                                                get_url_new_video(nameInServer),
                                            uid: widget.uid,
                                          )));
                            }
                          : () {}),
                ],
              ),
            ),
    );
  }
}
