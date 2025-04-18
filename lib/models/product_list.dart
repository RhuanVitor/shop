import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:shop/models/product.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favorite_items => _items.where( (product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<void> addProduct(Product product) async{
    final response = await http.post(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json'),
      body: jsonEncode({
        "name": product.title,
        "price": product.price,
        "description": product.description,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite
      })
    );
    final String id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id, 
      title: product.title, 
      description: product.description, 
      price: product.price, 
      imageUrl: product.imageUrl
    ));
    notifyListeners();
  }

  void removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      final product = _items[index];

      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json')
      );

      if(response.statusCode >= 400){
        items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: "Não foi possível excluir o produto!",
          statusCode: response.statusCode
        );
      }
    }
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      await http.patch(
        Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json'),
        body: jsonEncode({
          "name": product.title,
          "price": product.price,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite
        })
      );
      _items[index] = product;
      
      notifyListeners();
    }
  }
  
  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse('${Constants.PRODUCT_BASE_URL}.json'));
    if(response.body == 'null'){
      return ;
    } else{
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((productId, productData){
        _items.add(
          Product(
            id: productId,
            title: productData['name'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite']
          )
        );
      });
      notifyListeners();
    }
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