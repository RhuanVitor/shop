import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final String _baseUrl = 'https://shop-fb5ea-default-rtdb.firebaseio.com';
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favorite_items => _items.where( (product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<void> addProduct(Product product){
    final future = http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode({
        "name": product.title,
        "price": product.price,
        "description": product.description,
        "imageUrl": product.imageUrl,
      })
    );

    return future.then<void>((response){
      final String id = jsonDecode(response.body)['name'];
      _items.add(Product(
        id: id, 
        title: product.title, 
        description: product.description, 
        price: product.price, 
        imageUrl: product.imageUrl
      ));
      notifyListeners();  
    });
  }

  void removeProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      _items.remove(product);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null; 

    final product = Product(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        title: data['title'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['imageUrl'] as String,
      );

    if(hasId){
      return updateProduct(product);
    } else{
      return addProduct(product);
    }
  }
}