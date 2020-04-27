import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/custom_tile.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: CustomTile(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Tooltip(
                  message: product.title,
                  child: Text(
                    product.title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: (product.isFavorite)
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                onPressed: () async {
                  product
                      .toggleFavoriteStatus(auth.token, auth.userId)
                      .catchError((_) {
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Could not toggle the favorite status of this item!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  });
                }),
          ),
          backgroundColor: Colors.black54,
          trailing: Badge(
            onTap: () {
              cart.addItem(product.id, product.price, product.title);
              final snackBar = SnackBar(
                content: Text('Added to the cart.'),
                duration: Duration(seconds: 1, milliseconds: 200),
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: 'UNDO',
                  onPressed: () {
                    cart.decreaseItemQuantity(product.id);
                  },
                ),
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(snackBar);
            },
            value: cart.productInCartCount(product.id).toString(),
            color: Theme.of(context).primaryColor,
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                final snackBar = SnackBar(
                  content: Text('Added to the cart.'),
                  duration: Duration(seconds: 1, milliseconds: 200),
                  action: SnackBarAction(
                    textColor: Colors.white,
                    label: 'UNDO',
                    onPressed: () {
                      cart.decreaseItemQuantity(product.id);
                    },
                  ),
                );
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(snackBar);
              },
            ),
          ),
        ),
      ),
    );
  }
}
