import 'package:flutter/material.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'package:shop/components/product_grid.dart';
import 'package:shop/components/badgee.dart';
import 'package:shop/components/app_drawer.dart';

import 'package:shop/models/cart.dart';


enum FilterOptions {
  favorite, all
}

class ProductsOverviewPage extends StatefulWidget{
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    Provider.of<ProductList>(context, listen: false).loadProducts().then((value){
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feira Da Madrugada SP",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 20,
            ),
          ),
        actions: [
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
      body: _isLoading ? Center(
        child: CircularProgressIndicator()
      ) : ProductGrid(false /* show all products */),
      drawer: AppDrawer(),
    );
  }
}