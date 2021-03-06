import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lets_dance/screens/upload_video/face_tile.dart';
import 'package:lets_dance/screens/upload_video/save_video.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lets_dance/services/storage.dart';
import 'package:http/http.dart' as http;

import '../../services/database.dart';
import '../../shared/loading.dart';
import '../../shared/designs.dart';

class ChooseFace extends StatefulWidget {
  final String uid;
  final String username;
  late final VideoPlayerController videoPlayerController;
  final String backgroundName;
  final String avatarName;
  final String serverUrl;

  ChooseFace(
      {required this.uid,
      required this.username,
      required this.videoPlayerController,
      required this.backgroundName,
      required this.avatarName,
      required this.serverUrl});

  @override
  _ChooseFaceState createState() => _ChooseFaceState();
}

class _ChooseFaceState extends State<ChooseFace> {
  final DatabaseService _db = DatabaseService();
  bool loading = false;
  bool isNextActive = false;
  int selectedIndex = -1;
  final Storage storage = Storage();

  List<String> facesNames = [
    'Default',
    'Angle',
    'Bazz',
    'Beast',
    'Belle',
    'Boy',
    'Cinderella',
    'Crazy',
    'Crying',
    'Elsa',
    'Flower-Girl',
    'Girl',
    'Glasses',
    'Kiss',
    'Laugh',
    'Laugh-2',
    'MiniMouse',
    'Nerd',
    'NerdGirl',
    'Piggi',
    'Red-Angry',
    'Shocking',
    'Simba',
    'Star-Wars',
    'Stitch',
    'Sun',
    'Tinkerbell',
    'Unicorn-Poop',
    'Winking-Girl'
  ];

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
      isNextActive = true;
    });
  }

  void _sendDataToServer() async {
    var request = http.MultipartRequest(
        "POST", Uri.parse('http://172.20.1.109:8080/process'));
    request.fields['emoji'] = facesNames[selectedIndex];
    request.fields['background'] = widget.backgroundName;
    //request.fields['url'] = widget.serverUrl;
    request.files.add(await http.MultipartFile.fromPath(
        '${widget.username}_original_tmp',
        widget.videoPlayerController.dataSource));
    //request.fields['avatar'] = widget.avatar;
    print(request);
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) async {
        try {
          //var file = await File('/video.mp4').create(/*recrusive: true*/);
          var bytes = <int>[];
          response.stream.listen((newBytes) {
            bytes.addAll(newBytes);
          });
          Future<File> video = File('/video.mp4').writeAsBytes(bytes);
          //   response.stream.listen{
          //         (newBytes) {
          //       bytes.addAll(newBytes);
          //     },
          // onDone: () async{
          // await file.writeAsBytes(bytes);
          // }
          print(response);
          // setState(() {
          //   widget.videoPlayerController =
          //       VideoPlayerController.file(onValue.body);
          // });

          print('hi');
          // get your response here...
        } catch (e) {
          print(e);
          //Todo show message - upload your video again
        }
      });
    });
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
                  TextDesign(
                      text: 'Choose an emoji for your avatar:', size: 18),
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
                            facePath: 'images/faces/${facesNames[i]}.png',
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
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SaveVideo(
                                            videoPlayerController:
                                                widget.videoPlayerController,
                                            backgroundName:
                                                widget.backgroundName,
                                            avatarName: widget.avatarName,
                                            faceName: selectedIndex == 0
                                                ? 'None'
                                                : facesNames[selectedIndex] +
                                                    '.png',
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
