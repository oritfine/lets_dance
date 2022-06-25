import 'package:flutter/material.dart';

import '../designs.dart';

class MyMenuItem extends StatelessWidget {
  const MyMenuItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: text_color,
            ),
            const SizedBox(
              width: 25,
            ),
            TextDesign(text: name, size: 20)
          ],
        ),
      ),
    );
  }
}

class VideoMenuItem extends StatelessWidget {
  const VideoMenuItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: text_color,
            ),
            const SizedBox(
              width: 25,
            ),
            TextDesign(text: name, size: 20)
          ],
        ),
      ),
    );
  }
}
