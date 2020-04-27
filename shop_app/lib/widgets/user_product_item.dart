import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class UserProductItem extends StatelessWidget {
  final String title, imageUrl, productID;
  UserProductItem({
    @required this.productID,
    @required this.title,
    @required this.imageUrl,
  });

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: const Text('Do you want to remove this product item?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('YES'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            ),
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Tooltip(
          message: title,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditProductScreen.routeName,
                        arguments: productID);
                  }),
              Consumer<ProductsProvider>(
                builder: (_, product, child) => IconButton(
                    icon: child,
                    onPressed: () async {
                      final ret = await _asyncConfirmDialog(context);
                      if (ret == ConfirmAction.ACCEPT)
                        product.deleteProduct(productID).catchError((error) {
                          return showDialog<Null>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('An error Occured!'),
                              content: Text('Something went wrong.'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Okay'),
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                )
                              ],
                            ),
                          );
                        }).then((_) {
                          //Navigator.of(ctx).pop();
                        });
                    }),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
