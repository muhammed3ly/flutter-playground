import 'package:flutter/material.dart';

class Category {
  final String id, title;
  final Color color;
  const Category({
    @required this.id,
    this.color = Colors.orange,
    @required this.title,
  });
}
