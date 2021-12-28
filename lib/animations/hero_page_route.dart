import 'dart:ui';

import 'package:flutter/material.dart';

///USED TO CRAETE A CUSTOM TRANSITON ANIMATION LIKE HERO ANIMATION
class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  Color get barrierColor => Colors.black12;

  @override
  Curve get barrierCurve => Curves.elasticIn;

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => 'Popup dialog open';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  ImageFilter get filter => ImageFilter.blur(sigmaX: 20, sigmaY: 20);

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}
