import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard,
}

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id, title;
  final List<String> categories, ingredients, steps;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree, isVegan, isVegetarian, isLactoseFree;

  const Meal({
    @required this.id,
    @required this.title,
    @required this.categories,
    @required this.ingredients,
    @required this.steps,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
  });
}
