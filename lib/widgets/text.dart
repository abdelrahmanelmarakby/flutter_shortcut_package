import 'package:flutter/material.dart';

///THIS WIDGET IS USED TO CREATE A SIMPLE TEXT WIDGET
class Txt extends StatelessWidget {
  const Txt(this.text,
      {Key? key,
      this.color,
      this.weight = FontWeight.normal,
      this.size = 16,
      this.textAlign = TextAlign.center,
      this.shadows})
      : super(key: key);

  final Color? color;
  final List<Shadow>? shadows;
  final double size;
  final String text;
  final TextAlign textAlign;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
          color: color, fontWeight: weight, fontSize: size, shadows: shadows),
    );
  }
}
