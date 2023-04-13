import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sales_manager/app/core/exceptions/repository_exception.dart';
import 'package:sales_manager/app/core/rest_client/custom_dio.dart';
import 'package:sales_manager/app/models/sale_model.dart';

import './sales_repository.dart';

class SalesRepositoryImpl implements SalesRepository {
  final CustomDio dio;

  SalesRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<SaleModel>> loadSales() async {
    try {
      final result = await dio.auth().get("/sale");

      return result.data.map<SaleModel>((s) => SaleModel.fromMap(s)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar vendas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar vendas');
    }
  }

  @override
  Future<List<SaleModel>> loadPurchasesClient(int id) async {
    try {
      final result = await dio.auth().get("/sale?client_id=$id");

      return result.data.map<SaleModel>((s) => SaleModel.fromMap(s)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar compras do cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar compras do cliente');
    }
  }
  
  @override
  Future<void> deleteAllPurchasesClient(int id) async {
    try {
      await dio.auth().delete("/sale?client_id=$id");

    } on DioError catch (e, s) {
      log('Erro ao deletar compras do cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar compras do cliente');
    }
  }
  
  @override
  Future<void> deletePurchaseClient(int id) async {
    try {
      await dio.auth().delete("/sale?id=$id");

    } on DioError catch (e, s) {
      log('Erro ao deletar compras do cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar compras do cliente');
    }
  }
}
