import 'package:flutter/Material.dart';
import 'package:shop_app/screens/order_sceen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('Hello Friend'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('order'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
          },
        ),
      ]),
    );
  }
}
