import 'package:flutter/material.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

import 'package:provider/provider.dart';

import 'package:shop/components/app_drawer.dart';

class OrdersPage extends StatelessWidget{
  const OrdersPage({Key ? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meus pedidos"
        ),
        
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, index) => OrderWidget(order: orders.items[index]),
      ),
    );
  }
}