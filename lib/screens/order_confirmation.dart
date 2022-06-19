import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../provider/cart.dart';
import '../provider/orders.dart';

class OrderConfirmationScreen extends StatefulWidget {
  static const routeName = '/order-confirm';

  const OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Text(
              'Amount to be paid ₹ ${cart.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SlideAction(
                  elevation: 5,
                  innerColor: Colors.deepPurple,
                  outerColor: Colors.deepPurple[200],
                  text: 'Place order',
                  textStyle: TextStyle(fontSize: 25, color: Colors.white),
                  sliderButtonIcon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  onSubmit: () {
                    Provider.of<Order>(context, listen: false)
                        .addOrder(cart.items.values.toList(), cart.totalAmount);
                    cart.clear();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
