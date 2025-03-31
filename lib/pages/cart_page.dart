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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
            width: double.infinity,
            height: items.length * 90 + 10, 
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) => CardItemWidget(cartItem: items[index])),
            ),
          if(cart.itemsCount > 0)
          Card(
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      spacing: 160,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total: ',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                        Text(
                          'R\$ ${double.parse(cart.totalAmount.toString()).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: (){
                      Provider.of<OrderList>(context, listen: false).addOrder(cart);
                      cart.clear();
                    }, child: Text("Finalizar Pedido"),   )
                  ],
                ),
              ),
            ),
          if(cart.totalAmount == 0)
            Expanded(child: 
              Center(child: 
                Text(
                "Você não adicionou nenhum item ao carrinho!",
                )
              )
            )
          ],
        ),
      ),
    );
  }
}