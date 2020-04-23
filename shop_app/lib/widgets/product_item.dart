import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final String id, imageUrl, title;

  ProductItem({
    @required this.id,
    @required this.imageUrl,
    @required this.title,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.black54,
          title: Tooltip(
            message: widget.title,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
