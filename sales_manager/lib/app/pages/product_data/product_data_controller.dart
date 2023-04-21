import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/models/user_model.dart';
import 'package:sales_manager/app/pages/product_data/product_data_state.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';
import 'package:sales_manager/app/repositories/user/user_repository.dart';

class ProductDataController extends Cubit<ProductDataState> {
  final UserRepository _userRepository;
  final SalesRepository _salesRepository;
  final ClientsRepository _clientsRepository;

  ProductDataController(
    this._userRepository,
    this._salesRepository,
    this._clientsRepository,
  ) : super(const ProductDataState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: ProductDataStatus.loading));

    try {
      final user = await _userRepository.loadUser();
      final userData = await _userRepository.loadUserData(user.id);

      emit(state.copyWith(
        status: ProductDataStatus.loaded,
        user: userData,
      ));
    } catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: ProductDataStatus.error,
          errorMessage: 'Erro ao buscar dados do usuário',
        ),
      );
    }
  }

  Future<void> productUpdate(
    int id,
    ClientModel client,
    UserModel user,
    String productName,
    double price,
    double oldPrice,
    int quantity,
    int oldQuantity,
    String day,
    double total,
  ) async {
    emit(state.copyWith(status: ProductDataStatus.updating));

    try {
      _clientsRepository.updateDue(
        client.id.toString(),
        (client.due - (oldQuantity * oldPrice)) + price * quantity,
      );

      _userRepository.updateValuesUser(
        user.id,
        user.recebido,
        (user.receber - (oldQuantity * oldPrice)) + price * quantity,
        (user.totalVendido - (oldQuantity * oldPrice)) + price * quantity,
      );

      _salesRepository.updateSale(id, productName, day, quantity, price,
          total + ((price * quantity) - (oldPrice * oldQuantity)));

      emit(state.copyWith(
        status: ProductDataStatus.updated,
      ));
    } catch (e, s) {
      log('Erro ao atualizar venda', error: e, stackTrace: s);
      emit(state.copyWith(
        status: ProductDataStatus.error,
        errorMessage: 'Erro ao atualizar venda',
      ));
    }
  }
}
