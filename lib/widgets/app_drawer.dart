import 'package:flutter/Material.dart';
import 'package:shop_app/screens/order_sceen.dart';
import 'package:shop_app/screens/user_product.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text('Hello Friend'),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('order'),
          onTap: () {
            Navigator.of(context).pushNamed(OrderScreen.routeName);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Manage Products'),
          onTap: () {
            Navigator.of(context).pushNamed(UserProductScreen.routeName);
          },
        ),
      ]),
    );
  }
}
