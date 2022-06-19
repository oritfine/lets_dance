import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0),
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      //Flexible(
                      //child: Text(
                      Text(
                        widget.avatarName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      SizedBox(height: 7),
                      // ),
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
                  color: Colors.white.withOpacity(0),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      //Flexible(
                      // child: Text(
                      Text(
                        widget.avatarName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      //),
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
