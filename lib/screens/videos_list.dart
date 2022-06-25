import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:provider/provider.dart';

import '../models/video.dart';
import '../services/database.dart';
import '../shared/consts.dart';
import '../shared/consts_objects/floating_play_button.dart';
import '../shared/consts_objects/loading.dart';
import '../shared/consts_objects/video_object.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../models/video.dart';
import '../../services/database.dart';
// import '../consts.dart';
import '../shared/designs.dart';
// import '../shared/designs.dart';
// import 'floating_play_button.dart';
// import 'loading.dart';

class VideoWidget extends StatefulWidget {
  final String uid;
  final String url;
  final bool play;
  final bool showDetails;
  final Video video;
  //final bool isLiked;
  // final VoidCallback onTapLike;

  const VideoWidget({
    required this.url,
    required this.play,
    required this.showDetails,
    // required this.showName,
    required this.video,
    required this.uid,
    //required this.isLiked,
    /*required this.onTapLike*/
  });
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final DatabaseService _db = DatabaseService();
  bool isLiked = false;

  like() async {
    int prevLikersLength = widget.video.likers.length;
    print('prev:' + prevLikersLength.toString());
    int newLikersLength = await _db.addLiker(widget.uid, widget.video.video_id);
    print('curr:' + newLikersLength.toString());
    if (newLikersLength != -1 && newLikersLength != prevLikersLength) {
      await _db.addLike(widget.uid, widget.video.video_id);
    }
    setState(() {
      isLiked = !isLiked;
    });
  }

  unlike() async {
    int prevLikersLength = widget.video.likers.length;
    int newLikersLength =
        await _db.removeLiker(widget.uid, widget.video.video_id);
    if (newLikersLength != -1 && newLikersLength != prevLikersLength) {
      await _db.removeLike(widget.uid, widget.video.video_id);
    }
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(get_video_url + widget.url);
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
    return Column(
      children: [
        FutureBuilder(
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
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Loading(),
              );
            }
          },
        ),
        widget.showDetails
            ? Padding(
                padding: const EdgeInsets.only(left: 25, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextDesign(text: widget.video.name, size: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextDesign(
                            text: widget.video.likes.toString(), size: 20),
                        IconButton(
                            onPressed: isLiked
                                ? () async {
                                    unlike();
                                  }
                                : () async {
                                    //widget.onTap(videos);
                                    like();
                                    print('ontap');
                                    print('h');
                                  },
                            icon: isLiked
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red[900],
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    color: text_color,
                                  ))
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}

class VideoList extends StatefulWidget {
  final String uid;
  final onTap;
  final String? username;

  VideoList({required this.uid, required this.onTap, required this.username});
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final DatabaseService _db = DatabaseService();
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    //final videos = _db.videos;
    final videos = Provider.of<List<Video>>(context);
    Future.delayed(Duration.zero, () async {
      widget.onTap(videos);
    });

    like(index) async {
      int prevLikersLength = videos[index].likers.length;
      print('prev:' + prevLikersLength.toString());
      int newLikersLength =
          await _db.addLiker(widget.uid, videos[index].video_id);
      print('curr:' + newLikersLength.toString());
      if (newLikersLength != -1 && newLikersLength != prevLikersLength) {
        await _db.addLike(widget.uid, videos[index].video_id);
      }
      setState(() {
        isLiked = !isLiked;
      });
    }

    unlike(index) async {
      int prevLikersLength = videos[index].likers.length;
      print('prev:' + prevLikersLength.toString());
      int newLikersLength =
          await _db.removeLiker(widget.uid, videos[index].video_id);
      print('curr:' + newLikersLength.toString());
      if (newLikersLength != -1 && newLikersLength != prevLikersLength) {
        await _db.removeLike(widget.uid, videos[index].video_id);
      }
      setState(() {
        isLiked = !isLiked;
      });
    }

    print('after func');
    //print('hi');
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
                      // Future.delayed(Duration.zero, () async {
                      //   widget.onTap(videos);
                      // });
                      return Container(
                        //height: 500,
                        // child: Column(
                        //   children: [
                        child: VideoWidget(
                          uid: widget.uid,
                          play: isInView,
                          url: videos[index].url,
                          video: videos[index],
                          showDetails: true,
                          // showLikes: true,
                          // showName: true,
                        ),
                        // isLiked:
                        //     videos[index].likers.contains(widget.uid)
                        //         ? true
                        //         : false),
                        //   ],
                        // ),
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
