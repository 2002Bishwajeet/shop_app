import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/Models/CartModel.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/auth.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime time;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.time});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  String token;
  Auth _auth;

  set auth(Auth value) {
//   if (_auth != value) {
    _auth = value;
    token = _auth.token;
//   }
  }

  Future<void> fetchOrder() async {
    final url = Uri.parse(
        "https://shoeapp-e1665-default-rtdb.asia-southeast1.firebasedatabase.app/Orders.json?auth=$token");
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity'],
                  img: item['img']))
              .toList(),
          time: DateTime.parse(orderData['dateTime'])));
    });
    // print(response.body);
    _orders = loadedOrders.reversed.toList();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        "https://[project-name]-default-rtdb.asia-southeast1.firebasedatabase.app/Orders.json?auth=$token");
    final timestamp = DateTime
        .now(); //thoda time difference hoga isliye ek var mein daal diya
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                    'img': cp.img
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            time: timestamp));
    notifyListeners();
  }
}
