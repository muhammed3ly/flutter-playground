import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/ordersProvider.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (_, cart, child) => Chip(
                      label: Text(
                        '\$' + cart.totalPrice.toStringAsFixed(2),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Consumer<CartProvider>(
                    builder: (ctx, cart, child) => FlatButton(
                      child: child,
                      highlightColor: Theme.of(context).primaryColor,
                      onPressed: (cart.itemsCount > 0)
                          ? () {
                              Provider.of<OrdersProvider>(context,
                                      listen: false)
                                  .addOrder(cart.items.values.toList(),
                                      cart.totalPrice);
                              cart.clear();
                              final snackBar = SnackBar(
                                  content:
                                      Text('Your order has been recorded.'));
                              Scaffold.of(ctx).showSnackBar(snackBar);
                            }
                          : null,
                    ),
                    child: const Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Consumer<CartProvider>(
              builder: (_, cart, child) => ListView.builder(
                itemCount: cart.uniqueItemsCount,
                itemBuilder: (ctx, idx) => CartItemWidget(
                  productID: cart.items.keys.toList()[idx],
                  id: cart.items.values.toList()[idx].id,
                  title: cart.items.values.toList()[idx].title,
                  price: cart.items.values.toList()[idx].price,
                  quantity: cart.items.values.toList()[idx].quantity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
