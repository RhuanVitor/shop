import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/app_routes.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductItem extends StatelessWidget{
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final Product product = Provider.of<Product>(
      context,
      listen: false
    );

    final Cart cart = Provider.of<Cart>(
      context,
      listen: false
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.title, 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            ),
          backgroundColor: const Color.fromARGB(190, 0, 0, 0),
          
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: (){
                product.toggleFavorite();
              }, 
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.redAccent
            ),
          ),

          trailing: IconButton(
            onPressed: (){
              cart.addItem(product);
            }, 
            icon: Icon(Icons.shopping_cart),
            color: Colors.white
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: (){
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
        ),
      ),
    );
  }
}