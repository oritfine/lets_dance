import 'package:flutter/material.dart';
import 'package:lets_dance/services/auth.dart';
import 'package:lets_dance/shared/consts_objects/loading.dart';
import '../../shared/consts_objects/buttons.dart';
import '../../shared/designs.dart';

class SignIn extends StatefulWidget {
  //const ({Key? key}) : super(key: key);

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: background_color,
            appBar: AppBarDesign(text: 'Sign in to Lets Dance'),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textFormDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textFormDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    SizedBox(height: 20.0),
                    // Button(
                    //   text: 'Sign In',
                    //   color: appbar_color,
                    //   isAsync: true,
                    //   onPressed: () async {
                    //     if (_formKey.currentState!.validate()) {
                    //       setState(() => loading = true);
                    //       dynamic result = await _auth
                    //           .signInWithEmailAndPassword(email, password);
                    //       if (result == null) {
                    //         setState(() {
                    //           error =
                    //               'could not sign in with those credentials';
                    //           loading = false;
                    //         });
                    //       }
                    //     }
                    //   },
                    // ),
                    ElevatedButton(
                      style: buttonStyle,
                      child: TextDesign(text: 'Sign In', size: 18),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'could not sign in with those credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    TextButton.icon(
                        icon: Icon(
                          Icons.person,
                          color: text_color,
                        ),
                        onPressed: () {
                          widget.toggleView();
                        },
                        label: TextDesign(text: 'Register', size: 16)),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
