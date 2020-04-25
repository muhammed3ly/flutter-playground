import 'package:flutter/foundation.dart';

class CartItem {
  final String id, title;
  final int quantity;
  final double price;
  CartItem({
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    int ret = 0;
    for (var item in _items.values) ret += item.quantity;
    return ret;
  }

  int get uniqueItemsCount {
    return _items.length;
  }

  double get totalPrice {
    double ret = 0.0;
    for (var item in _items.values) ret += (item.price * item.quantity);
    return ret;
  }

  int productInCartCount(String productId) {
    if (_items.containsKey(productId)) return _items[productId].quantity;
    return 0;
  }

  void removeItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }

  void decreaseItemQuantity(String productId) {
    _items.update(
      productId,
      (existingCartItem) => CartItem(
        id: existingCartItem.id,
        price: existingCartItem.price,
        quantity: existingCartItem.quantity - 1,
        title: existingCartItem.title,
      ),
    );
    if (_items[productId].quantity <= 0) {
      removeItem(productId);
      return;
    }
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: price,
          quantity: existingCartItem.quantity + 1,
          title: existingCartItem.title,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          quantity: 1,
          title: title,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
