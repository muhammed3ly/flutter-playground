import 'package:flutter/material.dart';
import 'package:meals_app/dummy.dart';
import 'package:meals_app/models/meal.dart';
import 'dart:io';

class MealDetailsScreen extends StatefulWidget {
  static const String routeName = '/meal-details';
  final Function _toggleFavorite, _isMealFavorite;
  MealDetailsScreen(this._toggleFavorite, this._isMealFavorite);

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  Widget titleBuilder(BuildContext context, String s) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        s,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget containerBuilder(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 300,
      height: 150,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context).settings.arguments as String;
    final Meal meal = DUMMY_MEALS.firstWhere((m) => m.id == mealID);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            titleBuilder(context, "Ingredients"),
            containerBuilder(
              ListView.builder(
                itemBuilder: (ctx, idx) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(meal.ingredients[idx]),
                    ),
                  );
                },
                itemCount: meal.ingredients.length,
              ),
            ),
            titleBuilder(context, "Steps"),
            containerBuilder(
              ListView.builder(
                itemBuilder: (ctx, idx) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${idx + 1}'),
                        ),
                        title: Text(
                          meal.steps[idx],
                        ),
                      ),
                      if (idx != meal.steps.length - 1) Divider(),
                    ],
                  );
                },
                itemCount: meal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: (widget._isMealFavorite(mealID))
            ? Icon(
                Icons.star,
                color: Colors.white,
              )
            : Icon(
                Icons.star_border,
                color: Colors.white,
              ),
        onPressed: () {
          // Navigator.of(context).pop(mealID);
          widget._toggleFavorite(mealID);
        },
      ),
    );
  }
}
