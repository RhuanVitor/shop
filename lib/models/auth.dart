import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier{
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  bool get isAuth{
    final _isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && _isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }
  
  Future<void> _authenticate(String email, String password, String urlFragment) async{
    final _url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyA9Udddx8wzb8R8tcpb-LDAAV47L9Ol1FM';
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      })
    );
    final body = jsonDecode(response.body);

    if(body['error'] != null){
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']) 
        )
      );

      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'uid': _uid,
        'expiryDate': _expiryDate!.toIso8601String()
      });

      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async{
    debugPrint("isAuth: ${isAuth.toString()}");
    if(isAuth) return;

    final userData = await Store.getMap('userData');
    debugPrint("userData: ${userData.toString()}");

    debugPrint("userData.isEmpty: ${userData.isEmpty.toString()}");
    if (userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData['expiryDate']);
    
    debugPrint("expiryDate: ${expiryDate.toString()}");
    if(expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _uid = userData['uid'];
    _expiryDate = expiryDate;
    _autoLogout();
    notifyListeners();
  }

  void logout(){
    _token = '';
    _email = '';
    _uid = '';
    _expiryDate = null;
    _clearLogoutTimer();
    Store.remove('userData').then((_) => notifyListeners());
  }

  void _clearLogoutTimer(){
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout(){
    _clearLogoutTimer();
    final timeToLogout = _expiryDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout as int), logout);
  }
}