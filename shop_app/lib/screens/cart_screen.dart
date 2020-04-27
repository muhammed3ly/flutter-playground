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
                  OrderButton()
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
  }) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (ctx, cart, child) => FlatButton(
        child: child,
        highlightColor: Theme.of(context).primaryColor,
        onPressed: (cart.itemsCount > 0 && !_isLoading)
            ? () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<OrdersProvider>(context, listen: false)
                    .addOrder(cart.items.values.toList(), cart.totalPrice)
                    .then((_) {
                  cart.clear();
                  final snackBar =
                      SnackBar(content: Text('Your order has been recorded.'));
                  Scaffold.of(ctx).showSnackBar(snackBar);
                }).catchError((_) {
                  final snackBar = SnackBar(
                      content: Text('Your order could not be recorded!'));
                  Scaffold.of(ctx).showSnackBar(snackBar);
                });

                setState(() {
                  _isLoading = false;
                });
              }
            : null,
      ),
      child: _isLoading ? CircularProgressIndicator() : const Text('ORDER NOW'),
    );
  }
}
