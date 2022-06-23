import 'package:flutter/material.dart';
import 'package:lets_dance/shared/consts_objects/loading.dart';
import '../../shared/consts_objects/buttons.dart';
import '../../shared/designs.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // identify the form details
  bool loading = false;

  // text field state
  String username = '';
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
            appBar: AppBarDesign(text: 'Sign up to Lets Dance'),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textFormDecoration.copyWith(hintText: 'Username'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a username' : null,
                        onChanged: (val) {
                          setState(() => username = val);
                        }),
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
                    //   text: 'Register',
                    //   color: appbar_color,
                    //   isAsync: true,
                    //   onPressed: () async {
                    //     if (_formKey.currentState!.validate()) {
                    //       setState(() => loading = true);
                    //       dynamic result =
                    //           await _auth.registerWithEmailAndPassword(
                    //               username, email, password);
                    //       if (result == null) {
                    //         setState(() {
                    //           loading = false;
                    //           error = 'please supply a valid email';
                    //         });
                    //       }
                    //     }
                    //   },
                    // ),
                    ElevatedButton(
                      style: buttonStyle,
                      child: TextDesign(text: 'Register', size: 18),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  username, email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'please supply a valid email';
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
                        label: TextDesign(text: 'Sign In', size: 16)),
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
