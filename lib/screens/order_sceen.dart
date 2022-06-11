import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../provider/orders.dart' show Order;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.order.length,
          itemBuilder: (ctx, i) => OrderItem(
                order: orderData.order[i],
              )),
    );
  }
}
