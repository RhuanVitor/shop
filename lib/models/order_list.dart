import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';

class OrderList with ChangeNotifier{
  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart){
    _items.insert(0, 
    Order(
      id: Random().nextInt(100000000).toString().padLeft(9, '0'), 
      total: cart.totalAmount, 
      products: cart.items.values.toList(), 
      date: DateTime.now()
      )
    );
    notifyListeners();
  }
}