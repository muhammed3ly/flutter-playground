import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final String id, title, productID;
  final double price;
  final int quantity;

  CartItemWidget({
    @required this.productID,
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove this item from the cart?'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        cart.removeItem(productID);
      },
      background: Container(
          color: Colors.red,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          )),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(
                  '\$' + price.toStringAsFixed(2),
                ),
              ),
            ),
          ),
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            'Total: \$' + (price * quantity).toStringAsFixed(2),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          trailing: Container(
            width: 120,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.red,
                    size: 18,
                  ),
                  onPressed: () {
                    cart.decreaseItemQuantity(
                      productID,
                    );
                  },
                ),
                Text(
                  '$quantity x',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                    size: 18,
                  ),
                  onPressed: () {
                    cart.addItem(
                      productID,
                      price,
                      title,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
