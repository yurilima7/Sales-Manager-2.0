import 'package:sales_manager/app/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> loadUser();
  Future<UserModel> loadUserData(int id);
  Future<void> updateValuesUser(
      int id, double recebido, double receber, double totalVendido);
}
