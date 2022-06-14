import 'package:flutter/material.dart';

class BackgroundTile extends StatefulWidget {
  final String backgroundPath;
  final VoidCallback onTap;
  final bool selected;
  final int backgroundIndex;
  //const BackgroundTile({Key? key}) : super(key: key);
  BackgroundTile(
      {required this.backgroundPath,
      required this.onTap,
      required this.selected,
      required this.backgroundIndex});
  @override
  _BackgroundTileState createState() => _BackgroundTileState();
}

class _BackgroundTileState extends State<BackgroundTile> {
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
