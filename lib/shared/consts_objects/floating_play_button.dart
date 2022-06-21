import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FloatingPlayButton extends StatefulWidget {
  final VideoPlayerController controller;

  const FloatingPlayButton({super.key, required this.controller});
  @override
  _FloatingPlayButtonState createState() => _FloatingPlayButtonState();
}

class _FloatingPlayButtonState extends State<FloatingPlayButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            // Wrap the play or pause in a call to `setState`. This ensures the correct icon is shown
            setState(() {
              // If the video is playing, pause it
              if (widget.controller.value.isPlaying) {
                widget.controller.pause();
              } else {
                // If the video is paused, play it.
                widget.controller.play();
              }
            });
          },
          // Display the correct icon depending on the state of the player
          child: widget.controller.value.isPlaying
              ? Container()
              : Icon(
                  size: 65,
                  Icons.play_circle,
                  color: Colors.grey[400]?.withOpacity(0.7))),
    );
  }
}
