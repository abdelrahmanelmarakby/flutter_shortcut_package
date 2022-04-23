import 'package:flutter/material.dart';

///THIS WIDGET IS USED TO CREATE A SIMPLE TEXT WIDGET
class EaseTxt extends StatelessWidget {
  const EaseTxt(this.text,
      {Key? key,
      this.color,
      this.weight = FontWeight.normal,
      this.size = 16,
      this.textAlign = TextAlign.center,
      this.isSelectable = false,
      this.shadows,
      this.decoration,
      this.fontStyle,
      this.fontFamily})
      : super(key: key);

  final Color? color;
  final List<Shadow>? shadows;
  final double size;
  final String text;
  final TextAlign? textAlign;
  final FontWeight? weight;
  final bool isSelectable;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return isSelectable
        ? SelectableText(
            text,
            //overflow: TextOverflow.ellipsis,
            textAlign: textAlign,
            style: TextStyle(
                color: color,
                fontWeight: weight,
                fontSize: size,
                shadows: shadows),
          )
        : Text(
            text,
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign,
            style: TextStyle(
                decoration: decoration,
                fontStyle: fontStyle,
                fontFamily: fontFamily,
                color: color,
                fontWeight: weight,
                fontSize: size,
                shadows: shadows),
          );
  }
}
