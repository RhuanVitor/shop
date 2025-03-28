import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductsDetailPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: BorderDirectional(
              bottom: BorderSide(
                color: Colors.black12,
                width: 1.0
              )
            )
          ),
          child: Text(
            product.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal
            ),
            )
        ),
        backgroundColor: Colors.deepPurple
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(product.imageUrl, fit: BoxFit.cover,),
            ),
            SizedBox(height: 10,),
            Text(
              'R\$ ${product.price}',
              style: TextStyle(
                color: Colors.grey
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description
              ),
            )
          ],
        ),
      ),
    );
  }
}