import 'package:flutter/material.dart';

import 'package:shop/data/dummy_data.dart';

import '../models/product.dart';

import '../components/product_item.dart';

class ProductsOverviewPage extends StatelessWidget{

  final List<Product> loadedProducts = dummyProducts;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (ctx, index) => ProductItem(product: dummyProducts[index]),
        itemCount: loadedProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        )
      ),
    );
  }
}