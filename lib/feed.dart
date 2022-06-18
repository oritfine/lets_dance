// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:lets_dance/models/user.dart';
// import 'package:lets_dance/screens/home/user_tile.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
//
// import 'models/video.dart';
//
// class Feed extends StatefulWidget {
//   //const userList({Key? key}) : super(key: key);
//
//   @override
//   _FeedState createState() => _FeedState();
// }
//
// class _FeedState extends State<Feed> {
//   late VideoPlayerController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     print(context);
//     final videos = Provider.of<List<Video>>(context);
//     print('my users is:');
//     print(videos);
//     try {
//       videos.forEach((video) {
//         controller = VideoPlayerController.file(File(video.url))
//           ..initialize().then((_) {
//             //_videoPlayerController.play();
//           });
//         print(video.name);
//         print(video.likes);
//         print(video.url);
//       });
//     } catch (e) {
//       print('videos not found');
//       print(e.toString());
//     }
//     try {
//       return ListView.builder(
//         itemCount: videos.length,
//         itemBuilder: (context, index) {
//           return VideoCard(
//             video: videos[index],
//             controller: controller,
//           );
//         },
//       );
//     } catch (e) {
//       return Container();
//     }
//   }
// }
//
// class VideoCard extends StatelessWidget {
//   //const UserTile({Key? key}) : super(key: key);
//
//   final Video video;
//   final VideoPlayerController controller;
//   VideoCard({required this.video, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.only(top: 8.0),
//         child: Card(
//           margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//           child: Card(
//             child: Column(
//               children: [
//                 controller.value.isInitialized
//                     ? AspectRatio(
//                         aspectRatio: controller.value.aspectRatio,
//                         child: Stack(
//                           children: [
//                             VideoPlayer(controller),
//                             Align(
//                               alignment: Alignment.center,
//                               child: FloatingActionButton(
//                                 backgroundColor: Colors.white.withOpacity(0.0),
//                                 onPressed: () {
//                                   // Wrap the play or pause in a call to `setState`. This ensures the
//                                   // correct icon is shown.
//                                   setState(() {
//                                     // If the video is playing, pause it.
//                                     if (widget.videoPlayerController.value
//                                         .isPlaying) {
//                                       widget.videoPlayerController.pause();
//                                     } else {
//                                       // If the video is paused, play it.
//                                       widget.videoPlayerController.play();
//                                     }
//                                   });
//                                 },
//                                 // Display the correct icon depending on the state of the player.
//                                 child: Icon(
//                                   color: Colors.grey[400]?.withOpacity(0.7),
//                                   size: 65,
//                                   widget.videoPlayerController.value.isPlaying
//                                       ? Icons.pause
//                                       : Icons.play_circle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : Container(),
//                 Text(video.url),
//                 Row(
//                   children: [
//                     Container(
//                       child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(video.name)),
//                     ),
//                     SizedBox(width: 250),
//                     Container(
//                         child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Text(video.likes.toString())))
//                   ],
//                 ),
//               ],
//             ),
//             // title: Text(user.name),
//             // subtitle: Text('this is a user'),
//           ),
//         ));
//   }
// }
