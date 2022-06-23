import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lets_dance/shared/designs.dart';

import '../consts.dart';

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

class Generating extends StatelessWidget {
  //const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 1,
      color: background_color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitCircle(
            color: text_color,
            size: 50.0,
          ),
          SizedBox(
            height: 20,
          ),
          TextDesign(text: generate_text, size: 20),
        ],
      ),
    );
  }
}
