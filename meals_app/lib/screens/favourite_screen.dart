import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouriteScreen extends StatefulWidget {
  List<Meal> _favoriteMeals;
  FavouriteScreen(this._favoriteMeals);
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: (widget._favoriteMeals.isEmpty)
          ? Text('You have no favorites yet - start adding some!')
          : ListView.builder(
              itemBuilder: (ctx, idx) {
                return MealItem(
                  id: widget._favoriteMeals[idx].id,
                  title: widget._favoriteMeals[idx].title,
                  imageUrl: widget._favoriteMeals[idx].imageUrl,
                  duration: widget._favoriteMeals[idx].duration,
                  affordability: widget._favoriteMeals[idx].affordability,
                  complexity: widget._favoriteMeals[idx].complexity,
                );
              },
              itemCount: widget._favoriteMeals.length,
            ),
    );
  }
}
