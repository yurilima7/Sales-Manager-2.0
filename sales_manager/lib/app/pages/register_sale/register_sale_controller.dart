import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/models/user_model.dart';
import 'package:sales_manager/app/pages/register_sale/register_sale_state.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';
import 'package:sales_manager/app/repositories/user/user_repository.dart';

class RegisterSaleController extends Cubit<RegisterSaleState> {
  final UserRepository _userRepository;
  final SalesRepository _salesRepository;
  final ClientsRepository _clientsRepository;

  RegisterSaleController(
    this._userRepository,
    this._salesRepository,
    this._clientsRepository,
  ) : super(const RegisterSaleState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: RegisterSaleStatus.loading));

    try {
      final user = await _userRepository.loadUser();
      final userData = await _userRepository.loadUserData(user.id);

      emit(state.copyWith(
        status: RegisterSaleStatus.loaded,
        user: userData,
      ));
    } catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: RegisterSaleStatus.error,
          errorMessage: 'Erro ao buscar dados do usuário',
        ),
      );
    }
  }

  Future<void> registerSale(
    ClientModel client,
    UserModel user,
    String productName,
    double price,
    int quantity,
    String day,
  ) async {
    emit(state.copyWith(status: RegisterSaleStatus.registering));

    try {
      _clientsRepository.updateDue(
        client.id.toString(),
        client.due + (quantity * price),
      );

      _userRepository.updateValuesUser(
        user.id,
        user.recebido,
        user.receber + (price * quantity),
        user.totalVendido + (price * quantity),
      );

      _salesRepository.addSale(
        productName,
        day,
        quantity,
        price,
        price * quantity,
        client.id.toString(),
        user.id
      );

      emit(state.copyWith(
        status: RegisterSaleStatus.registered,
      ));
    } catch (e, s) {
      log('Erro ao adicionar venda', error: e, stackTrace: s);
      emit(state.copyWith(
        status: RegisterSaleStatus.error,
        errorMessage: 'Erro ao adicionar venda',
      ));
    }
  }
}
