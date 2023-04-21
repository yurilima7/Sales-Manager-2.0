import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sales_manager/app/core/exceptions/repository_exception.dart';
import 'package:sales_manager/app/core/rest_client/custom_dio.dart';
import 'package:sales_manager/app/models/user_model.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final CustomDio dio;

  UserRepositoryImpl({
    required this.dio,
  });

  @override
  Future<UserModel> loadUser() async {
    try {
      final result = await dio.auth().get("/me");

      return UserModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar usuário');
    }
  }
  
  @override
  Future<void> updateValuesUser(int id, double recebido, double receber, double totalVendido) async {
    try {
      await dio.auth().patch('/users_data/$id', data: {
        "total_vendido": totalVendido,
        "recebido": recebido,
        "receber": receber,
      });
    } on DioError catch (e, s) {
      log('Erro ao atualizar valores do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar valores do usuário');
    }
  }
  
  @override
  Future<UserModel> loadUserData(int id) async {
    try {
      final result = await dio.auth().get("/users_data/$id");

      return UserModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar usuário');
    }
  }
}
