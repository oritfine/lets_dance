import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lets_dance/screens/upload_video/avatar_tile.dart';
import 'package:lets_dance/screens/upload_video/choose_face.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lets_dance/services/storage.dart';
import 'package:lets_dance/shared/consts.dart';
import '../../shared/consts_objects/buttons.dart';
import '../../shared/designs.dart';

class ChooseAvatar extends StatefulWidget {
  final String uid;
  final String username;
  final File video;
  final String backgroundName;

  ChooseAvatar(
      {required this.uid,
      required this.username,
      required this.video,
      required this.backgroundName});

  @override
  _ChooseAvatarState createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
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
      appBar: AppBarDesign(text: 'Choose Avatar'),
      body: Padding(
        padding: EdgeInsets.only(left: 30, top: 20, right: 30),
        child: Column(
          children: [
            TextDesign(text: choose_avatar_text, size: 18),
            SizedBox(height: 18),
            Container(
              height: MediaQuery.of(context).size.height * 0.69,
              width: MediaQuery.of(context).size.width * 0.85,
              child: GridView.count(
                primary: false,
                //padding: const EdgeInsets.all(400),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
                childAspectRatio: (100.0 / 175.0),
                children: [
                  for (int i = 0; i < 4; i++)
                    AvatarTile(
                      avatarPath: get_image_path('avatar', avatarNames[i]),
                      onTap: () => selectIndex(i),
                      selected: i == selectedIndex,
                      avatarName: avatarNames[i],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 250),
              // child: isNextActive
              //     ? Button(
              //         text: 'Next',
              //         color: appbar_color,
              //         isAsync: false,
              //         onPressed: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => ChooseFace(
              //                         video: widget.video,
              //                         backgroundName: widget.backgroundName,
              //                         avatarName:
              //                             avatarNamesToSend[selectedIndex],
              //                         uid: widget.uid,
              //                         username: widget.username,
              //                       )));
              //         },
              //       )
              //     : Button(
              //         text: 'Next',
              //         color: disabled_next_color,
              //         isAsync: false,
              //         onPressed: () => {},
              //       )
              child: ElevatedButton(
                  style: isNextActive ? buttonStyle : disabledButtonStyle,
                  child: TextDesign(text: 'Next', size: 18),
                  onPressed: isNextActive
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseFace(
                                        video: widget.video,
                                        backgroundName: widget.backgroundName,
                                        avatarName:
                                            avatarNamesToSend[selectedIndex],
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
