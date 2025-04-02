import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favorite_items => _items.where( (product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  void addProduct(Product product){
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      _items.remove(product);
      notifyListeners();
    }
  }

  void updateProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      _items[index] = product;
      notifyListeners();
    }
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null; 

    final product = Product(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        title: data['title'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['imageUrl'] as String,
      );

    if(hasId){
      updateProduct(product);
    } else{
      addProduct(product);
    }
  }
}