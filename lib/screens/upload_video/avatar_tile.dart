import 'package:flutter/material.dart';
import '../../shared/designs.dart';

class AvatarTile extends StatefulWidget {
  final String avatarPath;
  final VoidCallback onTap;
  final bool selected;
  final String avatarName;

  AvatarTile(
      {required this.avatarPath,
      required this.onTap,
      required this.selected,
      required this.avatarName});
  @override
  _AvatarTileState createState() => _AvatarTileState();
}

class _AvatarTileState extends State<AvatarTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: widget.selected == true
            ? Container(
                decoration: BorderTileDesign,
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      TextDesign(text: widget.avatarName, size: 15),
                      SizedBox(height: 7),
                      Image.asset(
                        widget.avatarPath,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ))
            : Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      TextDesign(text: widget.avatarName, size: 15),
                      SizedBox(height: 7),
                      Image.asset(
                        widget.avatarPath,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                )));
  }
}
