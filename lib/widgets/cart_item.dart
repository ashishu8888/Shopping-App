import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartInItem extends StatelessWidget {
  const CartInItem(
      {Key? key,
      required this.id,
      required this.productID,
      required this.price,
      required this.quantity,
      required this.title})
      : super(key: key);

  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productID;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          color: Theme.of(context).errorColor),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productID);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Are you sure ?'),
                content: const Text(
                    'Do you want to remove the item from the cart ?'),
                actions: [
                  FlatButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  )
                ],
              );
            });
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(child: Text('₹ ${price}')),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: ₹ ${price * quantity}'),
          trailing: Text('$quantity x '),
        ),
      ),
    );
  }
}
