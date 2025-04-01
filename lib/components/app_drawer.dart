import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget{
  const AppDrawer({Key ? key}) : super(key:key);

    Widget build(BuildContext context){
      return Drawer(
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: Text("Bem vindo usuario"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: (){
                Navigator.of(context).pushNamed(AppRoutes.HOME);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Pedidos'),
              onTap: (){
                Navigator.of(context).pushNamed(AppRoutes.ORDERS);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Lista de desejos'),
              onTap: (){
                Navigator.of(context).pushNamed(AppRoutes.WISH_LIST);
              },
            ),            
            Divider(),
            ListTile(
              leading: Icon(Icons.build, color: const Color.fromARGB(255, 56, 32, 120),),
              textColor: const Color.fromARGB(255, 56, 32, 120),
              title: Text('Gerenciar produtos'),
              onTap: (){
                Navigator.of(context).pushNamed(AppRoutes.PRODUCTS);
              },
            ),            
          ],
        ),
      );
    }
}