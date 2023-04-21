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
  Future<List<SaleModel>> loadSales(String id) async {
    try {
      final result = await dio.auth().get("/sale?user_id=$id");

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
  Future<void> deletePurchaseClient(int id) async {
    try {
      await dio.auth().delete("/sale/$id");

    } on DioError catch (e, s) {
      log('Erro ao deletar compra do cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar compra do cliente');
    }
  }
  
  @override
  Future<void> addSale(String productName, String day, int quantity, double price, double total, String clientId, int id) async {
    try {
      await dio.auth().post("/sale", data: {
        "product_name": productName,
        "price": price,
        "quantity": quantity,
        "day": day,
        "total": total,
        "client_id": clientId,
        "user_id": id,
      });

    } on DioError catch (e, s) {
      log('Erro ao adicionar compra do cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao adicionar compra do cliente');
    }
  }
  
  @override
  Future<void> updateSale(int id, String productName, String day, int quantity, double price, double total) async {
    try {
      await dio.auth().put("/sale/$id", data: {
        "product_name": productName,
        "price": price,
        "quantity": quantity,
        "day": day,
        "total": total,
      });

    } on DioError catch (e, s) {
      log('Erro no update de compra do cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro no update de compra do cliente');
    }
  }
  
  @override
  Future<void> paymentSale(int id, double total) async {
    try {
      await dio.auth().patch("/sale/$id", data: {
        "total": total,
      });

    } on DioError catch (e, s) {
      log('Erro no pagamento do cliente', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro no pagamento do cliente');
    }
  }
}
