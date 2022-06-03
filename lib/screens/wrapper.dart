import 'package:flutter/material.dart';
import 'package:lets_dance/models/my_user.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    //return home or authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
    print(user);
  }
}
