// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import '../designs.dart';
//
// class Button extends StatefulWidget {
//   final String text;
//   final Color color;
//   final bool isAsync;
//   final Function() onPressed;
//
//   const Button(
//       {required this.text,
//       required this.onPressed,
//       required this.color,
//       required this.isAsync});
//   @override
//   _ButtonState createState() => _ButtonState();
// }
//
// class _ButtonState extends State<Button> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ,
//       onPressed: widget.isAsync
//           ? () async => widget.onPressed
//           : () => widget.onPressed,
//       child: TextDesign(text: widget.text, size: 18),
//     );
//   }
// }
