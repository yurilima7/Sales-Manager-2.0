import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sales_manager/app/core/exceptions/repository_exception.dart';
import 'package:sales_manager/app/core/exceptions/unauthorized_exception.dart';
import 'package:sales_manager/app/core/rest_client/custom_dio.dart';
import 'package:sales_manager/app/models/auth_model.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unauth().post('/auth', data: {
        'email': email,
        'password': password,
      });

      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Permissão negada', error: e, stackTrace: s);
        throw UnauthorizedException();
      }

      log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post('/users', data: {
        "name": name,
        "email": email,
        "password": password,
        "total_vendido": 0.0,
        "recebido": 0.0,
        "receber": 0.0
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar usuário');
    }
  }
  
  @override
  Future<void> updatePassword(int id, String password) async {
   try {
      await dio.auth().patch('/users/$id', data: {
        "password": password,
      });
    } on DioError catch (e, s) {
      log('Erro ao atualizar senha do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar senha do usuário');
    }
  }
}