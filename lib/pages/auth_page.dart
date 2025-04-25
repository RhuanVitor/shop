import 'package:flutter/material.dart';
import 'package:shop/components/auth_form.dart';

class AuthPage extends StatelessWidget{
  
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ss-logo-feira-de-madrugada-min.png', width: 180,),
            SizedBox(height: 20,),
            AuthForm(),
          ],
        ),
      ),
    );
  }
}