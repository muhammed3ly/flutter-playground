import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/widgets/badge.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context);
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
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: (product.isFavorite)
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                onPressed: product.toggleFavoriteStatus),
          ),
          backgroundColor: Colors.black54,
          title: Tooltip(
            message: product.title,
            child: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          trailing: Badge(
            value: cart.productInCartCount(product.id).toString(),
            color: Theme.of(context).primaryColor,
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
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
