import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/constants.dart';


class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  double price;
  final String imageUrl;
  bool isFavorite = false;

  Product({required this.id, required this.title, required this.description, required this.price, required this.imageUrl, this.isFavorite = false});

  Future<void> toggleFavorite(token, uid) async {
    isFavorite = !isFavorite;
    notifyListeners();
    final response =  await http.put( 
        Uri.parse('${Constants.USER_FAVORITE_URL}/$uid/$id.json?auth=$token'),
        body: jsonEncode({"isFavorite": isFavorite})
      );
    
    if(response.statusCode >= 400){
      isFavorite = !isFavorite;
    }
    notifyListeners();
  }

}