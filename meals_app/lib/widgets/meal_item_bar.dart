import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_bar_item.dart';

class MealItemBar extends StatelessWidget {
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  MealItemBar({
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
  });

  String get complexityToString {
    if (complexity == Complexity.Simple)
      return 'Simple';
    else if (complexity == Complexity.Hard)
      return 'Hard';
    else
      return 'Challenging';
  }

  String get affordabilityToString {
    if (affordability == Affordability.Affordable)
      return 'Affordable';
    else if (affordability == Affordability.Luxurious)
      return 'Expensive';
    else
      return 'Pricey';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          MealItemBarItem(
            icon: Icons.schedule,
            text: '$duration min',
          ),
          MealItemBarItem(
            icon: Icons.work,
            text: '$complexityToString',
          ),
          MealItemBarItem(
            icon: Icons.attach_money,
            size: 0,
            text: '$affordabilityToString',
          ),
        ],
      ),
    );
  }
}
