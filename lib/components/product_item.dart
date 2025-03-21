import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget{

  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(product.title, textAlign: TextAlign.center,),
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.favorite)
          ),
          trailing: IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.shopping_cart)
          ),
        ),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}