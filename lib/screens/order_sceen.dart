import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../provider/orders.dart' show Order;
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _orderFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Order>(context, listen: false).fetchAndSetOrder();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _orderFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              //// do error handing
              return const Center(
                child: Text("An error occured"),
              );
            } else {
              return Consumer<Order>(
                  builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.order.length,
                      itemBuilder: (ctx, i) => OrderItem(
                            order: orderData.order[i],
                          )));
            }
          }
        },
      ),
    );
  }
}
