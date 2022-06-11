import 'package:flutter/cupertino.dart';
import 'package:shop_app/provider/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Order with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get order {
    return [..._order];
  }

  void addOrder(List<CartItem> cartproducts, double total) {
    _order.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cartproducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
