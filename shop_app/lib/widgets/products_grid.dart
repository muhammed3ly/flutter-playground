import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showFav;
  ProductsGrid(this._showFav);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    final List<Product> products =
        (_showFav) ? productsData.favItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
        value: products[idx],
        child: ProductItem(),
      ),
      itemCount: products.length,
    );
  }
}
