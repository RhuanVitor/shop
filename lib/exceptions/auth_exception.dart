import 'package:flutter/material.dart';

class AuthException implements Exception{
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'Email já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Acesso bloqueado temporariamente. Tente mais tarde.',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID_PASSWORD': 'A senha informada não confere.',
    'USER_DISABLED': 'A conta do usuario foi desabilitada.',
    'INVALID_LOGIN_CREDENTIALS': 'Email ou senha estão invalidos.'
  };

  final String key;

  AuthException(this.key);

  @override
  String toString(){
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação.';
  }
}