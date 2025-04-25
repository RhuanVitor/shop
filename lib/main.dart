import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/models/auth.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/models/cart.dart';

import 'package:shop/pages/auth_or_home_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/product_page.dart';
import 'package:shop/pages/products_detail_page.dart';
import 'package:shop/pages/wish_list.dart';

import 'package:shop/utils/app_routes.dart';
void main() => runApp(MyAppHomePage());

class MyAppHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),

        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous){
            return ProductList(auth.token ?? '', auth.uid ?? '', previous?.items ?? []);
          }
        ),

        ChangeNotifierProvider(create: (_) => Cart()),
        
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous){
            return OrderList(auth.token ?? '', auth.uid ?? '', previous?.items ?? []);
          },
        ),
      ],
      child: MaterialApp(
        title: "flutter",
        theme: ThemeData(
          fontFamily: 'Lato'
        ),
        initialRoute: AppRoutes.AUTH_OR_HOME,
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductsDetailPage(),
          AppRoutes.CART_PAGE: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.WISH_LIST: (ctx) => WishList(),
          AppRoutes.PRODUCTS: (ctx) => ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}