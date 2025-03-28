import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

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
      child: Card(
        child: ListTile(
          title: Text(cartItem.name),
          leading: Image.network(cartItem.image),
          subtitle: Text('Total R\$ ${cartItem.price * cartItem.quantity}'),
          trailing: Text('${cartItem.quantity}x '),
        ),
      ),
    );
  }
}