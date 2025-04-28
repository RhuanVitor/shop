import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/constants.dart';

import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier{
  String _token;
  String _uid;
  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  OrderList([this._token = '', this._uid = '', this._items = const []]);

  Future<void> loadOrders() async {
    _items = [];

    final response = await http.get(
      Uri.parse('${Constants.ORDER_BASE_URL}/$_uid.json?auth=$_token')
    );

    if(response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    
    data.forEach((orderId, orderData){
      _items.add(
        Order(
          id: orderData['id'],
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item){
            return CartItem(
              id: item['id'],
              image: item['image'],
              productId: item['productId'],
              name: item['name'],
              quantity: item['quantity'],
              price: item['price']
            );
          }).toList(),
          date: DateTime.parse(orderData['date'])
        )
      );
    }); 
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final DateTime date = DateTime.now();
    final id = Random().nextInt(100000000).toString().padLeft(9, '0');

    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}/$_uid.json?auth=$_token',),
      body: jsonEncode({
        'id': id, 
        'total': cart.totalAmount,
        'products': cart.items.values.toList(),
        'date': date.toIso8601String(),
        'products': cart.items.values.map(
          (cartItem) => {
            'id': cartItem.id,
            'productId': cartItem.productId,
            'name': cartItem.name,
            'quantity': cartItem.quantity,
            'price': cartItem.price,
            'image': cartItem.image
          }
        ).toList(), 
      })
    );

    _items.insert(0, 
    Order(
      id: id, 
      total: cart.totalAmount, 
      products: cart.items.values.toList(), 
      date: date
      )
    );
    notifyListeners();
  }

  void cleanOrders(){
    _items = [];
  }

}