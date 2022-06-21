import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lets_dance/shared/designs.dart';

class Loading extends StatelessWidget {
  //const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background_color,
      child: Center(
        child: SpinKitCircle(
          color: text_color,
          size: 50.0,
        ),
      ),
    );
  }
}
