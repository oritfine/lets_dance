import 'package:flutter/material.dart';

import '../../shared/designs.dart';

class BackgroundTile extends StatefulWidget {
  final String backgroundPath;
  final VoidCallback onTap;
  final bool selected;
  final int backgroundIndex;
  BackgroundTile(
      {required this.backgroundPath,
      required this.onTap,
      required this.selected,
      required this.backgroundIndex});
  @override
  _BackgroundTileState createState() => _BackgroundTileState();
}

class _BackgroundTileState extends State<BackgroundTile> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: widget.selected == true
            ? Container(
                decoration: BorderTileDesign,
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Image.asset(
                    widget.backgroundPath,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ))
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Image.asset(
                    widget.backgroundPath,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                )));
  }
}
