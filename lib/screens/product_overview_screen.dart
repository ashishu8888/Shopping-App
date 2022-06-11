import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/productsGrid.dart';

import '../provider/cart.dart';

enum FilterOptions { Favourite, All }

class ProductOverViewScreen extends StatefulWidget {
  ProductOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Shop'),
          actions: [
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  //...
                  if (selectedValue == FilterOptions.Favourite) {
                    showFav();
                  } else {
                    showAll();
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (_) => [
                      const PopupMenuItem(
                        child: Text('Only Favourite'),
                        value: FilterOptions.Favourite,
                      ),
                      const PopupMenuItem(
                        child: Text('Show All'),
                        value: FilterOptions.All,
                      )
                    ]),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                  child: ch!,
                  value: cart.itemCount.toString(),
                  color: Colors.red),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            )
          ],
        ),
        drawer: const AppDrawer(),
        body: ProductsGrid(_isFav));
  }

  showFav() {
    setState(() {
      _isFav = true;
    });
  }

  showAll() {
    setState(() {
      _isFav = false;
    });
  }
}
