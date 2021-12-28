import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EaseTabBar extends StatefulWidget {
  const EaseTabBar(
      {Key? key,
      required this.child,
      this.background = Colors.blue,
      required this.iconButtons,
      this.colorMenuIconActivated = Colors.blue,
      this.colorMenuIconDefault = Colors.white,
      this.backgroundMenuIconActivated = Colors.white,
      this.backgroundMenuIconDefault = Colors.blue})
      : assert(iconButtons.length > 1 && iconButtons.length % 2 == 0),
        super(key: key);

  final Color background;
  final Color backgroundMenuIconActivated;
  final Color backgroundMenuIconDefault;
  final Widget child;
  final Color colorMenuIconActivated;
  final Color colorMenuIconDefault;
  final List<IconButton> iconButtons;

  @override
  _EaseTabBar createState() => _EaseTabBar();
}

class _EaseTabBar extends State<EaseTabBar> with TickerProviderStateMixin {
  late void Function() _listenerDown;
  late void Function() _listenerUp;

  late AnimationController _animationControllerDown;
  late AnimationController _animationControllerRotate;
  late AnimationController _animationControllerUp;
  late Animation<double> _animationDown;
  late Animation<double> _animationRotate;
  late Animation<double> _animationUp;
  //-1 button is quiet
  //0 button is moving
  //1 button is activated
  late BehaviorSubject<int> _isActivated;

  late PublishSubject<double> _opacity;
  late BehaviorSubject<double> _positionButton;

  @override
  void dispose() {
    _isActivated.close();
    _positionButton.close();
    _opacity.close();
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    _isActivated = BehaviorSubject.seeded(-1);
    _opacity = PublishSubject<double>();
    _positionButton = BehaviorSubject.seeded(10);

    _animationControllerUp = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationControllerDown = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationControllerRotate = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animationRotate = Tween<double>(begin: 0, end: 2.3).animate(
        CurvedAnimation(
            parent: _animationControllerRotate, curve: Curves.ease));

    _listenerUp = () {
      _opacity.sink.add(1.0);
      _positionButton.sink.add(_animationUp.value);
    };
    _animationControllerUp.addListener(_listenerUp);

    _listenerDown = () {
      _positionButton.sink.add(_animationDown.value);
    };
    _animationControllerDown.addListener(_listenerDown);
  }

  List<Widget> _buildMenuIcons() {
    List<Widget> icons = [];

    for (var i = 0; i < widget.iconButtons.length; i++) {
      if (i == widget.iconButtons.length / 2) {
        icons.add(SizedBox(
            width: MediaQuery.of(context).size.width /
                (widget.iconButtons.length + 1),
            height: 0));
      }
      icons.add(SizedBox(
          width: MediaQuery.of(context).size.width /
              (widget.iconButtons.length + 1),
          child: widget.iconButtons[i]));
    }

    return icons;
  }

  void _calculateOpacity(double dy) {
    var opacity = (MediaQuery.of(context).size.height - dy) /
        (MediaQuery.of(context).size.height * 0.3 - 60);
    if (opacity >= 0 && opacity <= 1) _opacity.sink.add(opacity);
  }

  void _updateButtonPosition(double dy) {
    var position = (MediaQuery.of(context).size.height - dy);

    if (position > 0) _positionButton.sink.add(position);

    _animationUp = Tween<double>(
            begin: position, end: MediaQuery.of(context).size.height * 0.7)
        .animate(CurvedAnimation(
            parent: _animationControllerUp, curve: Curves.ease));
    _animationDown = Tween<double>(begin: position, end: 10).animate(
        CurvedAnimation(parent: _animationControllerDown, curve: Curves.ease));
  }

  void _moveButtonDown() {
    _animationControllerDown.forward().whenComplete(() {
      _animationControllerDown.removeListener(_listenerDown);
      _animationControllerDown.reset();
      _animationDown.addListener(_listenerDown);
    });

    _animationControllerRotate.reverse();
    _isActivated.sink.add(-1);
  }

  void _moveButtonUp() {
    _animationControllerUp.forward().whenComplete(() {
      _animationControllerUp.removeListener(_listenerUp);
      _animationControllerUp.reset();
      _animationUp.addListener(_listenerUp);
    });

    _animationControllerRotate.forward();
    _isActivated.sink.add(1);
  }

  void _movementCancel(double dy) {
    if ((MediaQuery.of(context).size.height - dy) <
        MediaQuery.of(context).size.height * 0.3) {
      _moveButtonDown();
    } else {
      _moveButtonUp();
    }
  }

  void _finishedMovement(double dy) {
    if ((MediaQuery.of(context).size.height - dy).round() ==
        (MediaQuery.of(context).size.height * 0.3).round()) {
      _isActivated.sink.add(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Stack(children: <Widget>[
        StreamBuilder(
            stream: _isActivated.stream,
            builder: (context, AsyncSnapshot<int> snapshot) {
              return snapshot.data == -1
                  ? const SizedBox()
                  : StreamBuilder(
                      initialData: 0.0,
                      stream: _opacity.stream,
                      builder: (context, AsyncSnapshot<double> snapshot) {
                        return Opacity(
                            opacity: snapshot.data!.toDouble(),
                            child: StreamBuilder(
                                initialData: 0.0,
                                stream: _positionButton.stream,
                                builder:
                                    (context, AsyncSnapshot<double> snapshot) {
                                  var positon = snapshot.data! >=
                                          MediaQuery.of(context).size.height *
                                              0.3
                                      ? (MediaQuery.of(context).size.height *
                                              0.3) -
                                          (snapshot.data! -
                                              (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3))
                                      : snapshot.data;
                                  return ClipPath(
                                      clipper: ContainerClipper(positon!),
                                      child: Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          color: widget.background));
                                }));
                      });
            }),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildMenuIcons()),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Listener(
                      onPointerDown: (c) {
                        _isActivated.sink.add(0);
                      },
                      onPointerUp: (event) {
                        _movementCancel(event.position.dy);
                      },
                      onPointerMove: (event) async {
                        _updateButtonPosition(event.position.dy);
                        _calculateOpacity(event.position.dy);
                        _finishedMovement(event.position.dy);
                      },
                      child: StreamBuilder(
                          stream: _positionButton.stream,
                          initialData: 10.0,
                          builder: (context, AsyncSnapshot snapshot) {
                            return Padding(
                                padding: EdgeInsets.only(bottom: snapshot.data),
                                child: StreamBuilder(
                                    stream: _isActivated.stream,
                                    builder: (context, AsyncSnapshot snapshot) {
                                      return FloatingActionButton(
                                          elevation: 0,
                                          onPressed: () {
                                            _updateButtonPosition(0);
                                            if (_isActivated.stream.value ==
                                                1) {
                                              _moveButtonDown();
                                            } else {
                                              _moveButtonUp();
                                            }
                                          },
                                          child: Transform.rotate(
                                              angle: _animationRotate.value,
                                              child: Icon(Icons.add,
                                                  color: snapshot.data == -1
                                                      ? widget
                                                          .colorMenuIconDefault
                                                      : widget
                                                          .colorMenuIconActivated)),
                                          backgroundColor: snapshot.data == -1
                                              ? widget.backgroundMenuIconDefault
                                              : widget
                                                  .backgroundMenuIconActivated);
                                    }));
                          }))
                ])),
        Align(
          alignment: Alignment.topCenter,
          child: StreamBuilder(
              stream: _isActivated.stream,
              builder: (context, AsyncSnapshot<int> snapshot) {
                return snapshot.data == 1
                    ? Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: widget.child)
                    : const SizedBox();
              }),
        )
      ])
    ]);
  }
}

class MenuTabBarItem extends StatelessWidget {
  const MenuTabBarItem({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final void Function()? onTap;
  final Text label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: label, onTap: onTap);
  }
}

class ContainerClipper extends CustomClipper<Path> {
  ContainerClipper(this.dy);

  final double dy;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    if (dy > -20) {
      path.quadraticBezierTo((size.width / 2) - 28, size.height - 20,
          size.width / 2, size.height - dy - 56);
    }
    path.lineTo(size.width / 2, size.height - (dy == 0 ? 0 : (dy + 56)));
    if (dy > -20) {
      path.quadraticBezierTo(
          (size.width / 2) + 28, size.height - 20, size.width, size.height);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0.0, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
