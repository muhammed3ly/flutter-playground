import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/my_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScren extends StatelessWidget {
  static const String routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Consumer<ProductsProvider>(
        builder: (_, products, child) => Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (_, i) => UserProductItem(
              productID: products.items[i].id,
              title: products.items[i].title,
              imageUrl: products.items[i].imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
