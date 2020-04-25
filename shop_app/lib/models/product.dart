import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final title, description, imageUrl;
  String id;
  final double price;
  bool isFavorite;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });

  void set setID(String i) => id = i;
  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
