// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import '../../models/video.dart';
// import '../../services/database.dart';
// import '../consts.dart';
// import '../designs.dart';
// import 'floating_play_button.dart';
// import 'loading.dart';
//
// class VideoWidget extends StatefulWidget {
//   final String uid;
//   final String url;
//   final bool play;
//   final bool showDetails;
//   final Video video;
//   //final bool isLiked;
//   // final VoidCallback onTapLike;
//
//   const VideoWidget({
//     required this.url,
//     required this.play,
//     required this.showDetails,
//     // required this.showName,
//     required this.video,
//     required this.uid,
//     //required this.isLiked,
//     /*required this.onTapLike*/
//   });
//   @override
//   _VideoWidgetState createState() => _VideoWidgetState();
// }
//
// class _VideoWidgetState extends State<VideoWidget> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   final DatabaseService _db = DatabaseService();
//   bool isLiked = false;
//
//   like() async {
//     int prevLikersLength = widget.video.likers.length;
//     print('prev:' + prevLikersLength.toString());
//     int newLikersLength = await _db.addLiker(widget.uid, widget.video.video_id);
//     print('curr:' + newLikersLength.toString());
//     if (newLikersLength != -1 && newLikersLength != prevLikersLength) {
//       await _db.addLike(widget.uid, widget.video.video_id);
//     }
//     setState(() {
//       isLiked = !isLiked;
//     });
//   }
//
//   unlike() async {
//     int prevLikersLength = widget.video.likers.length;
//     int newLikersLength =
//         await _db.removeLiker(widget.uid, widget.video.video_id);
//     if (newLikersLength != -1 && newLikersLength != prevLikersLength) {
//       await _db.removeLike(widget.uid, widget.video.video_id);
//     }
//     setState(() {
//       isLiked = !isLiked;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = VideoPlayerController.network(get_video_url + widget.url);
//     _initializeVideoPlayerFuture = _controller.initialize().then((_) {
//       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//       setState(() {});
//     });
//
//     if (widget.play) {
//       _controller.play();
//       _controller.setLooping(true);
//     }
//   }
//
//   @override
//   void didUpdateWidget(VideoWidget oldWidget) {
//     if (oldWidget.play != widget.play) {
//       if (widget.play) {
//         _controller.play();
//         _controller.setLooping(true);
//       } else {
//         _controller.pause();
//       }
//     }
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FutureBuilder(
//           future: _initializeVideoPlayerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return Container(
//                 height: MediaQuery.of(context).size.height * 0.32,
//                 child: Stack(
//                   children: [
//                     VideoPlayer(_controller),
//                     FloatingPlayButton(
//                       controller: _controller,
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return Center(
//                 child: Loading(),
//               );
//             }
//           },
//         ),
//         widget.showDetails
//             ? Padding(
//                 padding: const EdgeInsets.only(left: 25, right: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextDesign(text: widget.video.name, size: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextDesign(
//                             text: widget.video.likes.toString(), size: 20),
//                         IconButton(
//                             onPressed: isLiked
//                                 ? () async {
//                                     unlike();
//                                   }
//                                 : () async {
//                                     //widget.onTap(videos);
//                                     like();
//                                     print('ontap');
//                                     print('h');
//                                   },
//                             icon: isLiked
//                                 ? Icon(
//                                     Icons.favorite,
//                                     color: Colors.red[900],
//                                   )
//                                 : Icon(
//                                     Icons.favorite_outline,
//                                     color: text_color,
//                                   ))
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             : Container(),
//       ],
//     );
//   }
// }
