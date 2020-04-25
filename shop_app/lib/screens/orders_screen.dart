import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/ordersProvider.dart';
import 'package:shop_app/widgets/my_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders-screen';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: MyDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, idx) => OrderItemWidget(ordersData.orders[idx]),
        itemCount: ordersData.orders.length,
      ),
    );
  }
}
