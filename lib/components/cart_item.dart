import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product_list.dart';

class CardItemWidget extends StatelessWidget{
  final CartItem cartItem;
  const CardItemWidget({Key? key, required this.cartItem}) : super(key: key);

  Widget build(BuildContext context){
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (_){
        Provider.of<Cart>(context, listen: false).removeItem(cartItem.productId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(
                cartItem.image,
                width: 75,
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      cartItem.name,
                      style: TextStyle(
                        fontSize: 13
                      ),
                    ),
                    Text(
                      'Total R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 13
                      ),
                    ),
                ],),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      if(cartItem.quantity == 1){
                        Provider.of<Cart>(context, listen: false).removeItem(cartItem.productId);
                      }
                      Provider.of<Cart>(context, listen: false).removeOne(cartItem.productId);
                    }, 
                    icon: Icon(Icons.remove, size: 13,)
                  ),
                  Text(
                    '${cartItem.quantity}',
                    style: TextStyle(
                      fontSize:12
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      Provider.of<Cart>(context, listen: false).addOne(cartItem.productId);
                    }, 
                    icon: Icon(Icons.add, size: 13)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}