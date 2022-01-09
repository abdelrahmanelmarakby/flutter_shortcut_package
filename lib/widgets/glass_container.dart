import 'dart:ui';

import 'package:flutter/material.dart';

//THIS WIDGET IS USED TO DISPLAY A CONTAINER WITH GLASSMORPIAN BACKGROUND
class EaseGlassContainer extends StatelessWidget {
  const EaseGlassContainer(
      {Key? key,
      required this.child,
      this.blur = 10,
      this.tileMode = TileMode.clamp,
      this.height,
      this.width})
      : super(key: key);

  final double blur;
  final Widget child;
  final double? height;
  final TileMode tileMode;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur, tileMode: tileMode),
      child: SizedBox(child: child, height: height, width: width),
    );
  }
}
