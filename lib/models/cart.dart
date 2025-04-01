import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';
import 'dart:math';

class Cart with ChangeNotifier{
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addOne(String id){
    _items.update(id, (existingItem) => CartItem(
        id: existingItem.id, 
        productId: existingItem.productId, 
        name: existingItem.name, 
        quantity: existingItem.quantity + 1, 
        price: existingItem.price,
        image: existingItem.image
      ));
    notifyListeners();
  }

  void removeOne(String id){
    if(_items[id]?.quantity == 1){
      removeItem(id);
    } else{
      _items.update(id, (existingItem) =>
      CartItem(
          id: existingItem.id, 
          productId: existingItem.productId, 
          name: existingItem.name, 
          quantity: existingItem.quantity - 1, 
          price: existingItem.price,
          image: existingItem.image
      ));
    }
    notifyListeners();
  }

  void addItem(Product product){
    if( _items.containsKey(product.id) ){
      _items.update(product.id, (existingItem) => CartItem(
        id: existingItem.id, 
        productId: existingItem.productId, 
        name: existingItem.name, 
        quantity: existingItem.quantity + 1, 
        price: existingItem.price,
        image: existingItem.image
        )
      );
    } else{
      _items.putIfAbsent(
        product.id, 
        () => CartItem(
          id: Random().nextDouble().toString(), 
          productId: product.id, 
          name: product.title, 
          quantity: 1,
          price: product.price,
          image: product.imageUrl
        )
      );
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }

  int get itemsCount => _items.length;

  double get totalAmount {
    double total = 0;

    _items.forEach((key, cartItem){
      total += cartItem.price * cartItem.quantity;      
     });

     return total;
  }
}