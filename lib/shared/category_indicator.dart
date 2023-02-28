import 'package:flutter/material.dart';

class CategoryIndicator extends StatelessWidget {
  final Color color;
  final double size;

  const CategoryIndicator({Key? key, required this.color, this.size = 16.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.0)),
    );
  }
}
