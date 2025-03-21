import 'package:flutter/material.dart';
import 'pages/products_overview_page.dart';

void main() => runApp(MyAppHomePage());


class MyAppHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "flutter",
      home: ProductsOverviewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}