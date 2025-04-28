import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget{
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with SingleTickerProviderStateMixin {
  
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
          _controller.forward();
          _authMode = AuthMode.Signup;
      } else {
          _controller.reverse();
        _authMode = AuthMode.Login;
      }
    });
  }


  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400
      )
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller, 
        curve: Curves.linear
      )
    );

    _slideAnimation = Tween(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller, 
        curve: Curves.linear
      )
    );
    
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext){
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
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

              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isLogin() ? 0 : 60,
                  maxHeight: _isLogin() ? 0 : 120,
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
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
                  ),
                ),
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
      )
    );
  }
}