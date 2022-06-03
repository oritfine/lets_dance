import 'package:flutter/material.dart';
import 'package:lets_dance/screens/home/userlist.dart';
import 'package:lets_dance/services/auth.dart';
import 'package:lets_dance/services/database.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';

class Home extends StatelessWidget {
  //const ({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Text('bottom sheet'),
            );
          });
    }

    return StreamProvider<List<User>>.value(
      // listening to stream of users which will reflect the firestore collection
      value: DatabaseService().users,
      catchError: (_, err) => null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Lets Dance!'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey[900],
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
                label:
                    Text('Log Out', style: TextStyle(color: Colors.grey[900]))),
            TextButton.icon(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey[900],
                ),
                onPressed: () => _showSettingsPanel(),
                label:
                    Text('Settings', style: TextStyle(color: Colors.grey[900])))
          ],
        ),
        body: userList(),
      ),
    );
  }
}
