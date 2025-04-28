import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/auth_form.dart';
import 'package:shop/models/order_list.dart';

class AuthPage extends StatefulWidget{
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  // @override
  // void initState(){
  //   super.initState();
  //   Provider.of<OrderList>(context, listen: false).cleanOrders();
  // }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: 
          Text(
            "Bem vindo(a)!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255)
            ),
          )
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/ss-logo-feira-de-madrugada-min.png', width: 220,),
              SizedBox(height: 20,),
              AuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}