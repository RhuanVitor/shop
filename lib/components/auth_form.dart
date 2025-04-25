import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget{
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  
  AuthMode _authMode = AuthMode.Login;

  final _passwordController = TextEditingController();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;
  bool _isLoading = false;

  void _showErrorDialog(String msg){
    showDialog(
      context: context, 
      builder: (ctx) => AlertDialog(
        title: Text("Ocorreu um erro!"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Fechar'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async{
    final isValid = _formKey.currentState?.validate() ?? false;

    if(!isValid){
      return;
    }
    setState(() {_isLoading = true;});

    _formKey.currentState?.save();

    Auth auth = Provider.of(context, listen: false);

    try{
      if(_isLogin()){
        await auth.login(_authData['email']!, _authData['password']!);
      } else{
        await auth.signup(_authData['email']!, _authData['password']!);
      }
    } on AuthException catch(error){
      _showErrorDialog(error.toString());
    } catch (error){
      _showErrorDialog("Ocorreu um erro!");
    }

    setState(() {_isLoading = false;});
  }

  void _switchAuthMode(){
    setState(() {
      if(_isLogin()){
          _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  Widget build(BuildContext){
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: _isLogin() ? 360 : 420,
        width: deviceSize.width * 0.80,
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                _isLogin() ? "Entrar" : "Criar conta",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email){
                  final email = _email ?? '';

                  if(email.trim().isEmpty || !email.contains("@") || !email.contains(".com") ){
                    return "Informe um email valido, deve conter @ e .com";
                  } else{
                    return null;
                  }
                },
              ),


              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: _passwordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (_password){
                  final password = _password ?? '';

                  if (password.isEmpty || password.length < 6){
                    return 'Informe uma senha valida, minimo de 5 caracteres';
                  } else {
                    return null;
                  } 
                },
              ),


              if(_isSignup())
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: _isLogin() ? 
                null : 
                (_password){
                  final password = _password ?? '';
                  if (password != _passwordController.text){
                    return 'As senhas informadas não conferem';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              _isLoading ?
              Center(child: CircularProgressIndicator(),) :
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent
                ),  
                onPressed: () => _submit() , 
                child: Text(
                  _authMode == AuthMode.Login ? 'Entrar' : 'Registrar',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),

              Spacer(),
              TextButton(
                onPressed: (){
                  _switchAuthMode();
                },
                child: Text(_isLogin() ? 
                  "Não possui uma conta?" : 
                  "Já possui uma conta?"
                )
              )
            ],
          )
        ),
      ),
    );
  }
}