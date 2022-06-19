import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/widgets/badge.dart';
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
    final cart = Provider.of<Cart>(context);
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
            trailing: Badge(
              value: cart.items[product.id] == null
                  ? 0.toString()
                  : cart.items[product.id]!.quantity.toString(),
              color: Colors.red,
              child: IconButton(
                iconSize: 30,
                icon: const Icon(Icons.shopping_cart),
                // ignore: deprecated_member_use
                color: Theme.of(context).accentColor,
                onPressed: () {
                  cart.addItem(
                    product.id,
                    product.price,
                    product.title,
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'item Added to Cart',
                      ),
                      action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            cart.removeSingleItem(product.id);
                          }),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
