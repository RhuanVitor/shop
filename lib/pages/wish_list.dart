import 'package:flutter/material.dart';
import 'package:shop/components/product_grid.dart';

class WishList extends StatelessWidget{
  const WishList ({Key ? key}) : super(key:key);

  final bool showFavoriteonly = true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de desejos"),
      ),
      body: ProductGrid(showFavoriteonly),
    );
  }
}