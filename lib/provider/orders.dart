import 'package:flutter/cupertino.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> fetchAndSetOrder() async {
    try {
      final url = Uri.parse(
          'https://learnflutter-cd98f-default-rtdb.firebaseio.com/orders.json');
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
            products: (orderData['products'] as List<dynamic>).map((Item) {
              return CartItem(
                  id: Item['id'],
                  title: Item['title'],
                  quantity: Item['quantity'],
                  price: Item['price']);
            }).toList(),
            dateTime: DateTime.parse(orderData['dateTime'])));
      });
      _order = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      print('$error in orders');
    }
  }

  Future<void> addOrder(List<CartItem> cartproducts, double total) async {
    final url = Uri.parse(
        'https://learnflutter-cd98f-default-rtdb.firebaseio.com/orders.json');
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartproducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));

    _order.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartproducts,
          dateTime: timeStamp,
        ));
    notifyListeners();
  }
}
