import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/products_detail_page.dart';
import 'package:shop/pages/wish_list.dart';

import 'package:shop/utils/app_routes.dart';

import 'pages/products_overview_page.dart';

void main() => runApp(MyAppHomePage());

class MyAppHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList(),),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList())
      ],
      child: MaterialApp(
        title: "flutter",
        theme: ThemeData(
          fontFamily: 'Lato'
        ),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.HOME: (ctx) => ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductsDetailPage(),
          AppRoutes.CART_PAGE: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.WISH_LIST: (ctx) => WishList(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}