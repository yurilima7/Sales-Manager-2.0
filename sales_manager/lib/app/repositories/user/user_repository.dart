import 'package:sales_manager/app/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> loadUser();
}
