import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:lets_dance/models/user.dart';
import 'package:lets_dance/shared/consts_objects/loading.dart';
import 'package:lets_dance/shared/menu/menu_item.dart';
import 'package:provider/provider.dart';
import '../../../shared/designs.dart';
import '../../services/database.dart';
import '../models/video.dart';
import '../shared/consts_objects/video_object.dart';

class MyVideosList extends StatefulWidget {
  String uid;
  List<Video> videos;
  MyVideosList({required this.uid, required this.videos});

  @override
  _MyVideosListState createState() => _MyVideosListState();
}

class _MyVideosListState extends State<MyVideosList> {
  final DatabaseService _db = DatabaseService();
  bool loading = false;
  List<Video> my_videos = [];

  void _showSettingsPanel(video_id) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: menu_background_color,
            height: MediaQuery.of(context).size.height * 0.19,
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
            child: Column(
              children: [
                MyMenuItem(
                  name: 'Delete video',
                  icon: Icons.delete,
                  onPressed: () => {_db.removeMyVideo(widget.uid, video_id)},
                ),
                SizedBox(height: 5),
                Divider(color: Colors.grey),
                SizedBox(height: 5),
                MyMenuItem(
                  name: 'Save video',
                  icon: Icons.download_rounded,
                  onPressed: () => {},
                ),
                // IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.delete,
                //       color: text_color,
                //       size: 35,
                //     )),
                // IconButton(
                //     onPressed: () {},
                //     icon: Icon(Icons.download_rounded,
                //         color: text_color, size: 35)),
              ],
            ),
          );
        });
  }

  Future<List<dynamic>> getDataFromDB() async {
    List<dynamic> video_ids = await _db.getVideosOfUser(widget.uid) as List;
    List<String> videos = [];
    video_ids.forEach((video) {
      _db.getVideoOfUser(video);
    });
    return videos;
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    print('my videos:');
    print(widget.videos);
    print(userModel);
    print(userModel.videos);
    print(userModel.videos[0]);
    //userModel.
    //List videos = await getDataFromDB();
    print('yy');
    print(userModel.name);
    widget.videos.forEach((video) => {
          if (video.user_id == widget.uid) {my_videos.add(video)}
        });
    print('my_videos are:');
    print(my_videos);
    return loading
        ? Loading()
        //: TextDesign(text: userModel.videos[0], size: 20)
        : Stack(
            fit: StackFit.expand,
            children: <Widget>[
              InViewNotifierList(
                scrollDirection: Axis.vertical,
                initialInViewIds: ['0'],
                isInViewPortCondition: (double deltaTop, double deltaBottom,
                    double viewPortDimension) {
                  return deltaTop < (0.5 * viewPortDimension) &&
                      deltaBottom > (0.5 * viewPortDimension);
                },
                itemCount: my_videos.length,
                builder: (BuildContext context, int index) {
                  //final videos = Provider.of<List<Video>>(context);
                  return Container(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.height * 0.8,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 30.0),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return InViewNotifierWidget(
                          id: '$index',
                          builder: (BuildContext context, bool isInView,
                              Widget? child) {
                            return Container(
                              //height: 500,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                        onPressed: () {
                                          _showSettingsPanel(
                                              my_videos[index].video_id);
                                        },
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: text_color,
                                        )),
                                  ),
                                  VideoWidget(
                                    uid: widget.uid,
                                    play: isInView,
                                    url: my_videos[index].url,
                                    showDetails: true,
                                    // showLikes: true,
                                    // showName: true,
                                    video: my_videos[index],
                                    // isLiked: my_videos[index]
                                    //         .likers
                                    //         .contains(widget.uid)
                                    //     ? true
                                    //     : false
                                    //onTap: () {},
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 25, right: 15),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       TextDesign(
                                  //           text: my_videos[index].name,
                                  //           size: 20),
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           TextDesign(
                                  //               text: my_videos[index]
                                  //                   .likes
                                  //                   .toString(),
                                  //               size: 20),
                                  //           IconButton(
                                  //               onPressed: () {
                                  //                 print('h');
                                  //                 // _db.addLike(
                                  //                 //     widget.uid, videos[index].);
                                  //               },
                                  //               icon: Icon(
                                  //                 Icons.favorite,
                                  //                 color: Colors.red[900],
                                  //               ))
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
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
            ],
          );
    // : StreamBuilder(
    //     stream: _db.user,
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         print('snapshot doesnt have data');
    //       }
    //       try {
    //         var userDoc = snapshot.data;
    //         if (userDoc != null) {
    //           return Text('videoList printing');
    //         } else {
    //           return Text('couldnt print video list');
    //         }
    //       } catch (e) {
    //         print('has error:');
    //         print(e);
    //         return Container();
    //       }
    //     })
    // children: [
    //   // check that the video is passed:
    //   // widget.videoPlayerController.value.isInitialized
    //   //     ? AspectRatio(
    //   //         aspectRatio: widget.videoPlayerController.value.aspectRatio,
    //   //         child: Stack(
    //   //           children: [
    //   //             VideoPlayer(widget.videoPlayerController),
    //   //             Align(
    //   //               alignment: Alignment.center,
    //   //               child: FloatingActionButton(
    //   //                 backgroundColor: Colors.white.withOpacity(0.0),
    //   //                 onPressed: () {
    //   //                   // Wrap the play or pause in a call to `setState`. This ensures the
    //   //                   // correct icon is shown.
    //   //                   setState(() {
    //   //                     // If the video is playing, pause it.
    //   //                     if (widget
    //   //                         .videoPlayerController.value.isPlaying) {
    //   //                       widget.videoPlayerController.pause();
    //   //                     } else {
    //   //                       // If the video is paused, play it.
    //   //                       widget.videoPlayerController.play();
    //   //                     }
    //   //                   });
    //   //                 },
    //   //                 // Display the correct icon depending on the state of the player.
    //   //                 child: Icon(
    //   //                   color: Colors.grey[400]?.withOpacity(0.7),
    //   //                   size: 65,
    //   //                   widget.videoPlayerController.value.isPlaying
    //   //                       ? Icons.pause
    //   //                       : Icons.play_circle,
    //   //                 ),
    //   //               ),
    //   //             ),
    //   //           ],
    //   //         ),
    //   //       )
    //   //     : Container(),
    //   //
    //   Text('Choose an emoji for your avatar:',
    //       style: TextStyle(color: Colors.black, fontSize: 18)),
    //   SizedBox(height: 20),
    //   // Container(
    //   //   height: 500,
    //   //   width: 400,
    //   //   child: GridView.builder(
    //   //     itemCount: 52,
    //   //     itemBuilder: (context, index) {
    //   //       return BackgroundTile(
    //   //         backgroundPath: 'images/background_images/$index.jpg',
    //   //       );
    //   //       // return Container(
    //   //       //   padding: const EdgeInsets.only(left: 5, right: 5),
    //   //       //   //elevation: 10,
    //   //       //   child: Center(
    //   //       //     child: Image.asset(
    //   //       //       values[index],
    //   //       //       //fit: BoxFit.fill,
    //   //       //     ),
    //   //       //   ),
    //   //       // );
    //   //     },
    //   //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //   //         crossAxisCount: 2),
    //   //   ),
    //   // ),
    //   Container(
    //     width: 400,
    //     height: 500,
    //     child: GridView.count(
    //       primary: false,
    //       //padding: const EdgeInsets.all(400),
    //       crossAxisSpacing: 16,
    //       mainAxisSpacing: 16,
    //       crossAxisCount: 3,
    //       childAspectRatio: (70.0 / 80.0),
    //       children: [
    //         for (int i = 0; i < 31; i++)
    //           FaceTile(
    //             facePath: 'images/faces/${facesNames[i]}.png',
    //             onTap: () => selectIndex(i),
    //             selected: i == selectedIndex,
    //             faceName: facesNames[i],
    //           ),
    //       ],
    //     ),
    //   ),
    //   /*show list from firebase storage - not in use for now
    //   Icon(Icons.photo, size: 200),
    //   FutureBuilder(
    //       future: storage.listFiles('backgrounds'),
    //       builder: (BuildContext context,
    //           AsyncSnapshot<firebase_storage.ListResult> snapshot) {
    //         if (snapshot.connectionState == ConnectionState.done &&
    //             snapshot.hasData) {
    //           return Container(
    //             //scrollDirection:
    //             padding: EdgeInsets.symmetric(horizontal: 20),
    //             height: 500,
    //             child: ListView.builder(
    //                 scrollDirection: Axis.vertical,
    //                 //shrinkWrap: true,
    //                 itemCount: snapshot.data!.items.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return Padding(
    //                     padding: const EdgeInsets.all(20.0),
    //                     child: snapshot.data!.items.isNotEmpty
    //                         ? FutureBuilder(
    //                             future: storage.downloadURL(snapshot
    //                                 .data!.items![index].fullPath),
    //                             builder: (BuildContext context,
    //                                 AsyncSnapshot<String> snapshot) {
    //                               if (snapshot.connectionState ==
    //                                       ConnectionState.done &&
    //                                   snapshot.hasData) {
    //                                 return Container(
    //                                     width: 300,
    //                                     height: 250,
    //                                     child: Image.network(
    //                                         snapshot.data!,
    //                                         fit: BoxFit.cover));
    //                               }
    //                               if (snapshot.connectionState ==
    //                                       ConnectionState.waiting ||
    //                                   !snapshot.hasData) {
    //                                 //TODO my circle progress
    //                                 print(snapshot);
    //                                 return CircularProgressIndicator();
    //                               }
    //                               return Container();
    //                             })
    //                         : Container(),
    //                   );
    //                 }),
    //           );
    //         }
    //         if (snapshot.connectionState == ConnectionState.waiting ||
    //             !snapshot.hasData) {
    //           //TODO my circle progress
    //           print(snapshot);
    //           return CircularProgressIndicator();
    //         }
    //         return Container();
    //       }),*/
    //   SizedBox(
    //     height: 20,
    //   ),
    //   // Padding(
    //   //   padding: EdgeInsets.only(left: 250),
    //   //   child: ElevatedButton(
    //   ElevatedButton(
    //       style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
    //       child: Text('Generate your Lets Dance video!',
    //           style: TextStyle(color: Colors.white)),
    //       onPressed: isNextActive
    //           ? () {
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => SaveVideo(
    //                   videoPlayerController:
    //                   widget.videoPlayerController,
    //                   backgroundName: widget.backgroundName,
    //                   faceName:
    //                   facesNames[selectedIndex] + '.png',
    //                 )));
    //       }
    //           : null),
    //   //),
    // ],

    //);
  }
}
