import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/Models/OrderModel.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;

  const OrderItemCard({Key key, this.order}) : super(key: key);

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.order.amount}"),
            subtitle:
                Text(DateFormat("dd/MM/yyyy hh:mm").format(widget.order.time)),
            trailing: IconButton(
                splashRadius: 12,
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                  _expanded ? LineIcons.angleUp : LineIcons.angleDown,
                  size: 20,
                )),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 20, 100),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ...widget.order.products
                      .map((e) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.title,
                                  softWrap: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500)),
                              Text("${e.quantity}x \$ ${e.price}"),
                            ],
                          ))
                      .toList(),
                ],
              ),
            )
        ],
      ),
    );
  }
}
