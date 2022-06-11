import 'package:flutter/material.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  bool isFav;
  ProductsGrid(this.isFav);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = isFav ? productData.FavItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index], // if we use the existing object
        child: ProductItem(
            // id: products[index].id,
            // title: products[index].title,
            // imageUrl: products[index].imageUrl,
            ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
    ;
  }
}
