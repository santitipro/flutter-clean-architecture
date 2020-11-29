import 'package:flutter/material.dart';

class BasicText extends StatelessWidget {
  String text;
  final double size;
  final double height;
  final double lineHeight;
  final Color color;
  final TextAlign align;
  final TextOverflow overflow;
  final FontWeight weight;

  BasicText(
      this.text,
      {Key key,
      this.height = 1.2,
      this.lineHeight = 0.4,
      this.weight = FontWeight.normal,
      this.size = 16.5,
      this.overflow = TextOverflow.visible,
      this.align = TextAlign.left,
      this.color = Colors.black})
      : assert(text != null), super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(text,
      overflow: overflow,
      textAlign: align,
      style: TextStyle(
        letterSpacing: lineHeight,
        height: height,
        color: color, fontSize: size, fontWeight: weight
      )
    );
  }
}
