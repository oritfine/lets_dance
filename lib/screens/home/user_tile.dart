import 'package:flutter/material.dart';
import 'package:lets_dance/models/user.dart';

class UserTile extends StatelessWidget {
  //const UserTile({Key? key}) : super(key: key);

  final User user;
  UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[user.num], //num=darkness of color
            ),
            title: Text(user.name),
            subtitle: Text('this is a user'),
          ),
        ));
  }
}
