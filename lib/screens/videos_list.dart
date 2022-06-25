import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:provider/provider.dart';

import '../models/video.dart';
import '../services/database.dart';
import '../shared/consts.dart';
import '../shared/consts_objects/video_object.dart';

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
                          url: get_video_url + videos[index].url,
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
