import 'package:flutter/material.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

import 'package:provider/provider.dart';

import 'package:shop/components/app_drawer.dart';

class OrdersPage extends StatefulWidget{
  const OrdersPage({Key ? key}) : super(key:key);


  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  Future<void> _refreshOrders(BuildContext context){
    return Provider.of<OrderList>(context, listen: false).loadOrders()
    .then((_){
      setState(() =>
        _isLoading = false
      );
    });
  }

  @override
  void initState(){
    super.initState();
    _refreshOrders(context);
  }

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
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : RefreshIndicator(
        onRefresh: () => _refreshOrders(context),
        child: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (ctx, index) => OrderWidget(order: orders.items[index]),
        ),
      ),
    );
  }
}