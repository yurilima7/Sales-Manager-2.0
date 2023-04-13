import 'package:sales_manager/app/models/sale_model.dart';

abstract class SalesRepository {
  Future<List<SaleModel>> loadSales();
  Future<List<SaleModel>> loadPurchasesClient(int id);
  Future<void> deleteAllPurchasesClient(int id);
  Future<void> deletePurchaseClient(int id);
}
