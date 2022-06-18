import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../models/video.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final bool play;

  const VideoWidget({Key? key, required this.url, required this.play})
      : super(key: key);
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
      print('play1');
      _controller.play();
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        print('playing');
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
          return Container(height: 300, child: VideoPlayer(_controller));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class VideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          itemCount: 5,
          builder: (BuildContext context, int index) {
            final videos = Provider.of<List<Video>>(context);

            return Container(
              width: double.infinity,
              height: 600.0,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return InViewNotifierWidget(
                    id: '$index',
                    builder:
                        (BuildContext context, bool isInView, Widget? child) {
                      return Container(
                        height: 500,
                        child: Column(
                          children: [
                            VideoWidget(play: isInView, url: videos[index].url),
                            // Row(
                            //   children: [
                            //     Container(
                            //       child: Align(
                            //           alignment: Alignment.centerLeft,
                            //           child: Text(videos[index].name)),
                            //     ),
                            //     SizedBox(width: 250),
                            //     Container(
                            //         child: Align(
                            //             alignment: Alignment.centerRight,
                            //             child: Text(
                            //                 videos[index].likes.toString())))
                            //   ],
                            // ),
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
        // Align(
        //   alignment: Alignment.center,
        //   child: Container(
        //     height: 1.0,
        //     color: Colors.redAccent,
        //   ),
        //)
      ],
    );
  }
}
