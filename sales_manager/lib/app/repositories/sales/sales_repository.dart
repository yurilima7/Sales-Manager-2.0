import 'package:sales_manager/app/models/sale_model.dart';

abstract class SalesRepository {
  Future<List<SaleModel>> loadSales(String id);
  Future<List<SaleModel>> loadPurchasesClient(int id);
  Future<void> deletePurchaseClient(int id);
  Future<void> updateSale(int id, String productName, String day, int quantity,
      double price, double total);
  Future<void> paymentSale(int id, double total);
  Future<void> addSale(String productName, String day, int quantity,
      double price, double total, String clientId, int id);
}
