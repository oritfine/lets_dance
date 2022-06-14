// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lets_dance/screens/upload_video/video_widget.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
//
// class BrowseVideo extends StatefulWidget {
//   const BrowseVideo({Key? key}) : super(key: key);
//
//   @override
//   _BrowseVideoState createState() => _BrowseVideoState();
// }
//
// class _BrowseVideoState extends State<BrowseVideo> {
//   late PlatformFile selected_video;
//   selected_video.Future<void> openFile(PlatformFile file) async {
//     print('Name: ${file.name}');
//     print('Name: ${file.bytes}');
//     print('Name: ${file.size}');
//     print('Name: ${file.extension}');
//     print('Name: ${file.path}');
//     OpenFile.open(file.path);
//     final newFile = await saveFilePermanently(file);
//     print('From Path: ${file.path}');
//     print('To Path: ${newFile.path}');
//   }
//
//   Future<File> saveFilePermanently(PlatformFile file) async {
//     final appStorage = await getApplicationDocumentsDirectory();
//     final newFile = File('${appStorage.path}/${file.name}');
//     return File(file.path!).copy(newFile.path);
//   }
//
//   Future capture() async {}
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Choose Video'),
//         centerTitle: true,
//       ),
//       body: Column(
//         //constraints: BoxConstraints(maxWidth: 400),
//         //padding: EdgeInsets.all(32),
//         //alignment: Alignment.center,
//         children: [
//           ElevatedButton(
//             child: Text('Browse your video'),
//             onPressed: () async {
//               //final result = await FilePicker.platform.pickFiles(allowMultiple: true); - for multiple files
//               final result =
//                   await FilePicker.platform.pickFiles(type: FileType.video);
//               if (result == null) {
//                 print('Video path is null');
//                 return;
//               }
//               final file = result.files.first;
//               setState(() {
//                 selected_video = file;
//               });
//               openFile(file);
//             },
//             // onPressed: () => capture(),
//           ),
//           Expanded(
//               child: selected_video == null
//                   ? Icon(Icons.photo, size: 120)
//                   : VideoWidget(selected_video)),
//         ],
//       ),
//     );
//   }
// }
//
// // class BrowseVideo extends StatelessWidget {
// //   //const BrowseVideo({Key? key}) : super(key: key);
// //   PlatformFile selected_video;
// //
// //   Future<void> openFile(PlatformFile file) async {
// //     print('Name: ${file.name}');
// //     print('Name: ${file.bytes}');
// //     print('Name: ${file.size}');
// //     print('Name: ${file.extension}');
// //     print('Name: ${file.path}');
// //     OpenFile.open(file.path);
// //     final newFile = await saveFilePermanently(file);
// //     print('From Path: ${file.path}');
// //     print('To Path: ${newFile.path}');
// //   }
// //
// //   Future<File> saveFilePermanently(PlatformFile file) async {
// //     final appStorage = await getApplicationDocumentsDirectory();
// //     final newFile = File('${appStorage.path}/${file.name}');
// //     return File(file.path!).copy(newFile.path);
// //   }
// //
// //   Future capture() async {}
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Choose Video'),
// //         centerTitle: true,
// //       ),
// //       body: Container(
// //         constraints: BoxConstraints(maxWidth: 400),
// //         padding: EdgeInsets.all(32),
// //         alignment: Alignment.center,
// //         child: ElevatedButton(
// //           child: Text('Browse your video'),
// //           onPressed: () async {
// //             //final result = await FilePicker.platform.pickFiles(allowMultiple: true); - for multiple files
// //             final result =
// //                 await FilePicker.platform.pickFiles(type: FileType.video);
// //             if (result == null) {
// //               print('Video path is null');
// //               return;
// //             }
// //             final file = result.files.first;
// //             setState(() {
// //               selected_video = file;
// //             });
// //             openFile(file);
// //           },
// //           // onPressed: () => capture(),
// //         ),
// //       ),
// //     );
// //   }
// // }
