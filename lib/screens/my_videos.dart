import 'package:flutter/material.dart';
import '../../shared/designs.dart';

class MyVideos extends StatelessWidget {
  const MyVideos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBarDesign(text: 'My Videos'),
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
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
            ),
      ),
    );
  }
}
