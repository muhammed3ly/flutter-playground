import 'package:flutter/material.dart';

class MealItemBarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final double size;

  MealItemBarItem({
    @required this.icon,
    @required this.text,
    this.size = 6,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(
          width: size,
        ),
        Text(text),
      ],
    );
  }
}
