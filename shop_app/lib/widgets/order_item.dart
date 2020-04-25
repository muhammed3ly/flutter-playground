import 'package:flutter/material.dart';
import 'package:shop_app/providers/ordersProvider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItemWidget extends StatefulWidget {
  final OrderItem order;

  OrderItemWidget(this.order);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$' + widget.order.amount.toStringAsFixed(2)),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          if (expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 30, 100),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, idx) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.order.products[idx].title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.order.products[idx].quantity}x \$' +
                            widget.order.products[idx].price.toStringAsFixed(2),
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
