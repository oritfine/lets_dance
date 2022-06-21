import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lets_dance/screens/upload_video/background_tile.dart';
import 'package:lets_dance/screens/upload_video/choose_avatar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lets_dance/services/storage.dart';
import 'package:lets_dance/shared/consts.dart';
import '../../shared/designs.dart';

class ChooseBackground extends StatefulWidget {
  final String uid;
  final String username;
  final File video;
  ChooseBackground(
      {required this.uid, required this.username, required this.video});

  @override
  _ChooseBackgroundState createState() => _ChooseBackgroundState();
}

class _ChooseBackgroundState extends State<ChooseBackground> {
  bool isNextActive = false;
  int selectedIndex = -1;
  final Storage storage = Storage();

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
      isNextActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBarDesign(text: 'Choose Background'),
      body: Padding(
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
            TextDesign(text: choose_background_text, size: 18),
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
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
                childAspectRatio: (170.0 / 110.0),
                children: [
                  for (int i = 1; i < 52; i++)
                    BackgroundTile(
                      backgroundPath: get_image_path('background', i.toString()),
                      onTap: () => selectIndex(i),
                      selected: i == selectedIndex,
                      backgroundIndex: i,
                    ),
                ],
              ),
            ),
            /*show list from firebase storage - not in use for now
            Icon(Icons.photo, size: 200),
            FutureBuilder(
                future: storage.listFiles('backgrounds'),
                builder: (BuildContext context,
                    AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Container(
                      //scrollDirection:
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 500,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          //shrinkWrap: true,
                          itemCount: snapshot.data!.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: snapshot.data!.items.isNotEmpty
                                  ? FutureBuilder(
                                      future: storage.downloadURL(snapshot
                                          .data!.items![index].fullPath),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData) {
                                          return Container(
                                              width: 300,
                                              height: 250,
                                              child: Image.network(
                                                  snapshot.data!,
                                                  fit: BoxFit.cover));
                                        }
                                        if (snapshot.connectionState ==
                                                ConnectionState.waiting ||
                                            !snapshot.hasData) {
                                          //TODO my circle progress
                                          print(snapshot);
                                          return CircularProgressIndicator();
                                        }
                                        return Container();
                                      })
                                  : Container(),
                            );
                          }),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    //TODO my circle progress
                    print(snapshot);
                    return CircularProgressIndicator();
                  }
                  return Container();
                }),*/
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 250),
              child: ElevatedButton(
                  style: isNextActive ? button_style : disabled_next_style,
                  child: TextDesign(text: 'Next', size: 18),
                  onPressed: isNextActive
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseAvatar(
                                        video: widget.video,
                                        backgroundName:
                                            selectedIndex.toString() + '.jpg',
                                        uid: widget.uid,
                                        username: widget.username,
                                      )));
                        }
                      : () {}),
            ),
          ],
        ),
      ),
    );
  }
}
