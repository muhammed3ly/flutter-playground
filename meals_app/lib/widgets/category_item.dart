import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title, id;
  final Color color;

  CategoryItem({@required this.id, @required this.color, @required this.title});

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealsScrean.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
