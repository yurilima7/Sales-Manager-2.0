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
  Future<List<ClientModel>> loadClients(String id) async {
    try {
      final result = await dio.auth().get("/client?user_id=$id");

      return result.data
          .map<ClientModel>((c) => ClientModel.fromMap(c))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar clientes', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar clientes');
    }
  }
  
  @override
  Future<void> addClient(String name, String phone, String district, String street, int number, double due, String userId) async {
    try {
      await dio.auth().post("/client", data: {
        "name": name,
        "phone": phone,
        "district": district,
        "street": street,
        "number": number,
        "due": due,
        "user_id": userId,
      });

    } on DioError catch (e, s) {
      log('Erro ao inserir cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao inserir cliente');
    }
  }
  
  @override
  Future<void> deleteClient(int id) async {
    try {
      await dio.auth().delete('/client/$id');
    } on DioError catch (e, s) {
      log('Erro ao deletar cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar cliente');
    }
  }
  
  @override
  Future<void> updateClient(String id, String name, String phone, String district, String street, int number, double due) async {
     try {
      await dio.auth().put('/client/$id', data: {
        "name": name,
        "phone": phone,
        "district": district,
        "street": street,
        "number": number,
        "due": due,
        "user_id": '#userAuthRef'
      });
    } on DioError catch (e, s) {
      log('Erro ao atualizar dados do cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar dados do cliente');
    }
  }
  
  @override
  Future<void> updateDue(String id, double due) async {
    try {
      await dio.auth().patch("/client/$id", data: {
        "due": due,
      });

    } on DioError catch (e, s) {
      log('Erro ao atualizar divida do cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar divida do cliente');
    }
  }
  
}
