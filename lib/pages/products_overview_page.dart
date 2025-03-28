import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../components/product_grid.dart';
import '../components/badgee.dart';
import '../components/app_drawer.dart';

import '../models/cart.dart';


enum FilterOptions {
  favorite, all
}

class ProductsOverviewPage extends StatefulWidget{
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context){
    

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feira Da Madrugada SP",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.filter_list_alt,
              color: Colors.white,
            ),
            itemBuilder: (_) => [
               PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text("Somente favoritos"),
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text("Todos"),
              ),
            ],
            onSelected: (FilterOptions selectedOption){
              if(selectedOption == FilterOptions.favorite){
                setState(() {
                  _showFavoriteOnly = true;
                });
              } else if(selectedOption == FilterOptions.all){
                  setState(() {
                    _showFavoriteOnly = false;
                });
              }
            },
          ), 
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badgee(
              value: cart.itemsCount.toString(),
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(
                    AppRoutes.CART_PAGE
                  );
                }, 
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                )
              ),
            ),
          )
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}