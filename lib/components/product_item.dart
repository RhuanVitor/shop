import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/models/product.dart';

class ProductItem extends StatelessWidget{
  final Product product;

  const ProductItem({required this.product});

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(
        product.title,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        width: 96,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.edit) 
            ),
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.delete) 
            )
          ],
        ),
      ),
    );
  }
}