import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/order_confirmation.dart';
import '../provider/cart.dart';
import '../provider/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/Cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(children: [
        Card(
          elevation: 4,
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '₹ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleSmall!
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: const Text('Order Now'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(OrderConfirmationScreen.routeName);
                    },
                    textColor: Theme.of(context).primaryColor,
                  )
                ]),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, i) => CartInItem(
              id: cart.items.values.toList()[i].id,
              productID: cart.items.keys.toList()[i],
              price: cart.items.values.toList()[i].price,
              quantity: cart.items.values.toList()[i].quantity,
              title: cart.items.values.toList()[i].title,
            ),
            itemCount: cart.itemCount,
          ),
        )
      ]),
    );
  }
}
