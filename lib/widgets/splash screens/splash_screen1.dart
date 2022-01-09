import 'dart:async';

import 'package:flutter/material.dart';

class EaseSplashScreen extends StatefulWidget {
  const EaseSplashScreen(
      {required this.homePage,
      Key? key,
      required this.logo,
      required this.slogan,
      this.backgroundColor = Colors.white,
      this.duration = const Duration(milliseconds: 1000),
      this.curve = Curves.easeIn})
      : super(key: key);

  final Color backgroundColor;
  final Curve curve;
  final Duration duration;
  final Widget homePage;
  final Widget logo;
  final String slogan;

  @override
  _EaseSplashScreenState createState() => _EaseSplashScreenState();
}

class _EaseSplashScreenState extends State<EaseSplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation1;

  double _containerOpacity = 0.0;
  double _containerSize = 1.5;
  late AnimationController _controller;
  double _fontSize = 2;
  double _textOpacity = 0.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    animation1 = Tween<double>(begin: 120, end: 20)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(widget.duration, () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(widget.duration * 1.75, () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(widget.duration * 2.5, () {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => widget.homePage));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                AnimatedContainer(
                    duration: widget.duration,
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _height / _fontSize),
                AnimatedOpacity(
                  duration: widget.duration,
                  opacity: _textOpacity,
                  child: Text(
                    ///ADD YOUR SLOGAN HERE
                    widget.slogan,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: AnimatedOpacity(
                duration: widget.duration,
                curve: Curves.fastLinearToSlowEaseIn,
                opacity: _containerOpacity,
                child: AnimatedContainer(
                    duration: widget.duration,
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _width / _containerSize,
                    width: _width / _containerSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: widget.logo)),
          ),
        ],
      ),
    );
  }
}

class PageTransition1 extends PageRouteBuilder {
  PageTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.easeIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );

  final Widget page;
}
