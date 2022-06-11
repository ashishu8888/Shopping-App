import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/Product-Detail';
  // final String title;
//  const ProductDetail({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)!.settings.arguments as String;
    final Selectedproduct =
        Provider.of<Products>(context, listen: false).findById(productID);
    return Scaffold(
      appBar: AppBar(title: Text(Selectedproduct.title)),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(Selectedproduct.imageUrl),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '₹ ${Selectedproduct.price}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              Selectedproduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
