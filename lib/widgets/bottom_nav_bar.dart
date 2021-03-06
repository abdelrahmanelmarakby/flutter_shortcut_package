import 'package:flutter/material.dart';

/// A Widget that displays a Bottom Navgation Bar with smooth animation.
/// It is a wrapper around [BottomNavigationBar]
/// [EaseNavBar] is a widget that displays a horizontal row of tabs, one tab at a time.
/// The tabs are individually titled and, when tapped, switch to that tab.
///* credits to and inspired by FlashyTabBar2 package https://pub.dev/packages/flashy_tab_bar2
class EaseNavBar extends StatelessWidget {
  EaseNavBar({
    Key? key,
    this.selectedIndex = 0,
    this.height = 60,
    this.showElevation = true,
    this.iconSize = 20,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 170),
    this.animationCurve = Curves.linear,
    this.shadows = const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 3,
      ),
    ],
    required this.items,
    required this.onItemSelected,
    this.floating = true,
  }) : super(key: key) {
    assert(height >= 55 && height <= 100);
    assert(items.length >= 2 && items.length <= 5);
  }

  final Curve animationCurve;
  final Duration animationDuration;
  final Color? backgroundColor;
  final bool floating;
  final double height;
  final double iconSize;
  final List<EaseNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int selectedIndex;
  final List<BoxShadow> shadows;
  final bool showElevation;

  @override
  Widget build(BuildContext context) {
    final bg = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Padding(
      padding: floating ? const EdgeInsets.all(12.0) : const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          boxShadow: showElevation ? shadows : [],
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: height,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items.map((item) {
                var index = items.indexOf(item);
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onItemSelected(index),
                    child: _FlashTabBarItem(
                      item: item,
                      tabBarHeight: height,
                      iconSize: iconSize,
                      isSelected: index == selectedIndex,
                      backgroundColor: bg!,
                      animationDuration: animationDuration,
                      animationCurve: animationCurve,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/// A single tab in the [EaseNavBar]. A tab has a title and an icon. The title is displayed when the item is not selected. The icon is displayed when the item is selected. Tabs are always used in conjunction with a [EaseNavBar].
class EaseNavBarItem {
  EaseNavBarItem({
    required this.icon,
    required this.title,
    this.activeColor = const Color(0xff272e81),
    this.inactiveColor = const Color(0xff9496c1),
  });

  Color activeColor;
  final Icon icon;
  Color inactiveColor;
  final Text title;
}

class _FlashTabBarItem extends StatelessWidget {
  const _FlashTabBarItem(
      {Key? key,
      required this.item,
      required this.isSelected,
      required this.tabBarHeight,
      required this.backgroundColor,
      required this.animationDuration,
      required this.animationCurve,
      required this.iconSize})
      : super(key: key);

  final Curve animationCurve;
  final Duration animationDuration;
  final Color backgroundColor;
  final double iconSize;
  final bool isSelected;
  final EaseNavBarItem item;
  final double tabBarHeight;

  @override
  Widget build(BuildContext context) {
    /// The icon is displayed when the item is not selected.
    /// The title is displayed when the item is selected.
    /// The icon and title are animated together.
    /// The icon and title are animated in opposite directions.
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
          color: backgroundColor,
          height: double.maxFinite,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedAlign(
                duration: animationDuration,
                child: AnimatedOpacity(
                    opacity: isSelected ? 1.0 : 1.0,
                    duration: animationDuration,
                    child: IconTheme(
                      data: IconThemeData(
                          size: iconSize,
                          color: isSelected
                              ? item.activeColor.withOpacity(1)
                              : item.inactiveColor),
                      child: item.icon,
                    )),
                alignment: isSelected ? Alignment.topCenter : Alignment.center,
              ),
              AnimatedPositioned(
                curve: animationCurve,
                duration: animationDuration,
                top: isSelected ? -2.0 * iconSize : tabBarHeight / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: iconSize,
                      height: iconSize,
                    ),
                    CustomPaint(
                      child: SizedBox(
                        width: 80,
                        height: iconSize,
                      ),
                      painter: _CustomPath(backgroundColor),
                    )
                  ],
                ),
              ),
              AnimatedAlign(
                  alignment:
                      isSelected ? Alignment.center : Alignment.bottomCenter,
                  duration: animationDuration,
                  curve: animationCurve,
                  child: AnimatedOpacity(
                      opacity: isSelected ? 1.0 : 0.0,
                      duration: animationDuration,
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: item.activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        child: item.title,
                      ))),
              Positioned(
                  bottom: 0,
                  child: CustomPaint(
                    child: SizedBox(
                      width: 80,
                      height: iconSize,
                    ),
                    painter: _CustomPath(backgroundColor),
                  )),

              /// This is the selected item indicator
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                    duration: animationDuration,
                    opacity: isSelected ? 1.0 : 0.0,
                    child: Container(
                      width: 5,
                      height: 5,
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: item.activeColor,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    )),
              )
            ],
          )),
    );
  }
}

/// A [CustomPainter] that draws a [EaseNavBar] background.
class _CustomPath extends CustomPainter {
  _CustomPath(this.backgroundColor);

  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, 0);
    path.lineTo(0, 2.0 * size.height);
    path.lineTo(1.0 * size.width, 2.0 * size.height);
    path.lineTo(1.0 * size.width, 1.0 * size.height);
    path.lineTo(0, 0);
    path.close();

    paint.color = backgroundColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
