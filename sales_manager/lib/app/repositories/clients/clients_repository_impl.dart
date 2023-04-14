import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sales_manager/app/core/exceptions/repository_exception.dart';
import 'package:sales_manager/app/core/rest_client/custom_dio.dart';
import 'package:sales_manager/app/models/client_model.dart';

import './clients_repository.dart';

class ClientsRepositoryImpl implements ClientsRepository {
  final CustomDio dio;

  ClientsRepositoryImpl({required this.dio});

  @override
  Future<List<ClientModel>> loadClients() async {
    try {
      final result = await dio.auth().get("/client");

      return result.data
          .map<ClientModel>((c) => ClientModel.fromMap(c))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar clientes', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar clientes');
    }
  }
  
  @override
  Future<void> addClient(int name, String phone, String district, String street, int number, double due, String userId) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteClient(int id) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateClient(int name, String phone, String district, String street, int number, double due) {
    throw UnimplementedError();
  }
}
