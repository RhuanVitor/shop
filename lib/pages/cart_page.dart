import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/order_list.dart';

class CartPage extends StatelessWidget{
  const CartPage({ Key? key }) : super(key:key);

  @override
  Widget build (BuildContext context){
    final Cart cart = Provider.of<Cart>(context, listen: true);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Carrinho",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700
          ),
        ),
        backgroundColor: Colors.deepPurple
      ),
      body: Column(
        children: [
          Card(
            child: Row(
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                Chip(
                  label: Text('R\$ ${double.parse(cart.totalAmount.toString()).toStringAsFixed(2)}'),

                ),
                TextButton(onPressed: (){
                  Provider.of<OrderList>(context, listen: false).addOrder(cart);
                  cart.clear();
                }, child: Text("Finalizar Pedido"),   )
              ],
            ),
          ),
          Expanded(child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => CardItemWidget(cartItem: items[index])),
          )
        ],
      ),
    );
  }
}