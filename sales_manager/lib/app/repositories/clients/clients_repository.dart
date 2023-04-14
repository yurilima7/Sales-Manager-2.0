import 'package:sales_manager/app/models/client_model.dart';

abstract class ClientsRepository {
  Future<List<ClientModel>> loadClients();
  Future<void> addClient(int name, String phone, String district, String street,
      int number, double due, String userId);
  Future<void> updateClient(int name, String phone, String district,
      String street, int number, double due);
  Future<void> deleteClient(int id);
}
