import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/http_exceptions.dart';
import 'package:shop_app/provider/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items]; // returning copy of item not reference.
  }

  Product findById(String id) {
    var found = Product(
        id: "null", title: "", description: "", price: -1, imageUrl: "");
    bool flag = false;
    for (var element in _items) {
      if (element.id == id) {
        flag = true;
      }
    }
    if (flag == false) {
      return found;
    }
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchANDSetProduct() async {
    final url = Uri.parse(
        'https://learnflutter-cd98f-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.get(url);
      //
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      // print(json.decode(response.body));
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
          ),
        );
      });
      _items = loadedProducts;
    } catch (error) {
      print('$error in Products');
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://learnflutter-cd98f-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavourite,
          }));

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print('$error in Products/add');
      throw error;
    }
  }

  List<Product> get FavItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    final url = Uri.parse(
        'https://learnflutter-cd98f-default-rtdb.firebaseio.com/products/$id.json');
    await http.patch(url,
        body: jsonEncode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        }));

    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('invalid update index!,i m  in products');
    }
  }

  Future<void> deleteProducts(String id) async {
    final url = Uri.parse(
        'https://learnflutter-cd98f-default-rtdb.firebaseio.com/products/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;
  }
}
