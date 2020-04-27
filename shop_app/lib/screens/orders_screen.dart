import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/ordersProvider.dart';
import 'package:shop_app/widgets/my_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSetOrders(),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (dataSnapShot.error == null) {
            return Consumer<OrdersProvider>(
              builder: (_, ordersData, child) => (ordersData.orders.length > 0)
                  ? ListView.builder(
                      itemBuilder: (ctx, idx) =>
                          OrderItemWidget(ordersData.orders[idx]),
                      itemCount: ordersData.orders.length,
                    )
                  : Center(
                      child: child,
                    ),
              child: const Text('You have not orderd anything yet!'),
            );
          } else {
            return Center(
              child: const Text('An error has occured!'),
            );
          }
        },
      ),
    );
  }
}
