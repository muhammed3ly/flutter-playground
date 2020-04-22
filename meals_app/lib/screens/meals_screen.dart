import 'package:flutter/material.dart';
import 'package:meals_app/dummy.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScrean extends StatefulWidget {
  static const String routeName = '/category-meals';
  final List<Meal> _availableMeals;
  MealsScrean(this._availableMeals);
  @override
  _MealsScreanState createState() => _MealsScreanState();
}

class _MealsScreanState extends State<MealsScrean> {
  String catID, catTitle;
  List<Meal> categoryMeals;
  bool _loadedData = false;
  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      catID = routeArgs['id'];
      catTitle = routeArgs['title'];
      categoryMeals = widget._availableMeals
          .where((meal) => meal.categories.contains(catID))
          .toList();
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, idx) {
            return MealItem(
              id: categoryMeals[idx].id,
              title: categoryMeals[idx].title,
              imageUrl: categoryMeals[idx].imageUrl,
              duration: categoryMeals[idx].duration,
              affordability: categoryMeals[idx].affordability,
              complexity: categoryMeals[idx].complexity,
            );
          },
          itemCount: categoryMeals.length,
        ),
      ),
    );
  }
}
