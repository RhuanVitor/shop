import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsPage extends StatelessWidget{
  Future<void> _refreshProducts(BuildContext context){
    return Provider.of<ProductList>(
      context, 
      listen: false
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context){
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar produtos"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM
              );
            }, 
            icon: Icon(Icons.add)
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, index){
              return Column(
                children: [
                  ProductItem(product: products.items[index]),
                  Divider()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}