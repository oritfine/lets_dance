import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:flutter/material.dart';
import 'package:lets_dance/shared/consts_objects/floating_play_button.dart';
import 'package:lets_dance/shared/consts_objects/loading.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../models/video.dart';
import '../services/database.dart';
import '../shared/designs.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final bool play;
  final VoidCallback onTap;

  const VideoWidget(
      {required this.url, required this.play, required this.onTap});
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    if (widget.play) {
      _controller.play();
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.play();
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.32,
            child: Stack(
              children: [
                VideoPlayer(_controller),
                FloatingPlayButton(
                  controller: _controller,
                )
              ],
            ),
          ); //,
        } else {
          return Center(
            child: Loading(),
          );
        }
      },
    );
  }
}

class VideoList extends StatefulWidget {
  final String uid;

  VideoList({required this.uid});
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final DatabaseService _db = DatabaseService();

  onTap() {}

  @override
  Widget build(BuildContext context) {
    //final videos = _db.videos;
    final videos = Provider.of<List<Video>>(context);
    //Future<int> length = videoscol.length;
    //List<bool> myLikes = List.filled(length, false);
    // int i = 0;
    // videos.forEach((video) {
    //   if (video.likers.contains(widget.uid)) {
    //     //myLikes[i] = true;
    //   }
    //   i++;
    // });

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InViewNotifierList(
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
                deltaBottom > (0.5 * viewPortDimension);
          },
          itemCount: videos.length,
          builder: (BuildContext context, int index) {
            //final videos = Provider.of<List<Video>>(context);
            return Container(
              width: double.infinity,
              //height: MediaQuery.of(context).size.height * 0.8,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return InViewNotifierWidget(
                    id: '$index',
                    builder:
                        (BuildContext context, bool isInView, Widget? child) {
                      return Container(
                        //height: 500,
                        child: Column(
                          children: [
                            VideoWidget(
                              play: isInView,
                              url: videos[index].url,
                              onTap: onTap(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextDesign(
                                      text: videos[index].name, size: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextDesign(
                                          text: videos[index].likes.toString(),
                                          size: 20),
                                      IconButton(
                                          onPressed: () {
                                            print('h');
                                            // _db.addLike(
                                            //     widget.uid, videos[index].);
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.red[900],
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
