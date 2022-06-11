import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import '../provider/cart.dart';
import '../provider/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // const ProductItem(
  //     {required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetail.routeName, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GridTileBar(
            title: Text(
              product.title,
              style: const TextStyle(fontSize: 9),
            ),
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Colors.redAccent,
                onPressed: () {
                  product.toggleFavouriteStatus();
                },
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(
                  product.id,
                  product.price,
                  product.title,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
