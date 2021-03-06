import 'package:flutter/material.dart';
import '../../shared/designs.dart';

class FaceTile extends StatefulWidget {
  final String facePath;
  final VoidCallback onTap;
  final bool selected;
  final String faceName;

  FaceTile(
      {required this.facePath,
      required this.onTap,
      required this.selected,
      required this.faceName});
  @override
  _FaceTileState createState() => _FaceTileState();
}

class _FaceTileState extends State<FaceTile> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.only(top: 8.0),
//         child: Card(
//           margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//           child: ListTile(
//             // leading: CircleAvatar(
//             //   radius: 25.0,
//             //   backgroundColor: Colors.brown[user.num], //num=darkness of color
//             // ),
//             title: Text(user.name),
//             //subtitle: Text('this is a user'),
//           ),
//         ));
//   }
// }

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
                      //Flexible(
                      //child: Text(
                      TextDesign(text: widget.faceName, size: 15),
                      SizedBox(height: 7),
                      // ),
                      Image.asset(
                        widget.facePath,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ))
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      //Flexible(
                      // child: Text(
                      TextDesign(text: widget.faceName, size: 15),
                      //),
                      SizedBox(height: 7),
                      Image.asset(
                        widget.facePath,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                )));
  }
}
