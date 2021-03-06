import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const background_color = Color.fromRGBO(18, 17, 18, 1);
const appbar_color = Color.fromRGBO(87, 72, 231, 1.0);
const button_color = Color.fromRGBO(87, 72, 231, 1.0);
final text_color = Colors.grey[300];
final disabled_next_style =
    ElevatedButton.styleFrom(primary: Colors.white54.withOpacity(0.5));

const textFormDecoration = InputDecoration(
    fillColor: Color.fromRGBO(224, 224, 224, 1),
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromRGBO(224, 224, 224, 1), width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: button_color, width: 2.0)));

class TextDesign extends StatelessWidget {
  const TextDesign({Key? key, required this.text, required this.size})
      : super(key: key);
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.josefinSans(
          fontWeight: FontWeight.w600, fontSize: size, color: text_color),
    );
  }
}

class AppBarDesign extends StatelessWidget implements PreferredSizeWidget {
  AppBarDesign({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appbar_color,
      title: TextDesign(text: text, size: 24),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

final BorderTileDesign = BoxDecoration(
  color: Colors.white.withOpacity(0),
  border: Border.all(
    color: text_color!,
    width: 5,
  ),
);

final button_style = ElevatedButton.styleFrom(primary: appbar_color);
