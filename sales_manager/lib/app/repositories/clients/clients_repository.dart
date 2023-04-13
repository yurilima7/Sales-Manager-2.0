import 'package:sales_manager/app/models/client_model.dart';

abstract class ClientsRepository {
  Future <List <ClientModel>> loadClients();
}
