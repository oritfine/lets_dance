import 'package:flutter/material.dart';
import 'package:lets_dance/models/user.dart';
import 'package:lets_dance/screens/home/user_tile.dart';
import 'package:provider/provider.dart';

class userList extends StatefulWidget {
  //const userList({Key? key}) : super(key: key);

  @override
  _userListState createState() => _userListState();
}

class _userListState extends State<userList> {
  @override
  Widget build(BuildContext context) {
    print(context);
    final users = Provider.of<List<UserModel>>(context);
    print('my users is:');
    print(users);
    // users.forEach((user) {
    //   print(user.name);
    //   print(user.number);
    // });
    try {
      users.forEach((user) {
        print(user.name);
        //print(user.num);
      });
    } catch (e) {
      print('users not found');
      print(e.toString());
    }
    // if (users != null) {
    //   users.forEach((user) {
    //     print(user.name);
    //     print(user.number);
    //   });
    // for (var doc in users.docs) {
    //   print(doc.data());
    // }
    //}
    try {
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserTile(user: users[index]);
        },
      );
    } catch (e) {
      return Container();
    }
  }
}
