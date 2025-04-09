import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';


class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  double price;
  final String imageUrl;
  bool isFavorite = false;

  Product({required this.id, required this.title, required this.description, required this.price, required this.imageUrl, isFavorite = false});

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();
    final response =  await http.patch( 
        Uri.parse('${Constants.PRODUCT_BASE_URL}/$id.json'),
        body: jsonEncode({"isFavorite": isFavorite})
      );
    
    if(response.statusCode >= 400){
      isFavorite = !isFavorite;
    }
    notifyListeners();
  }

}