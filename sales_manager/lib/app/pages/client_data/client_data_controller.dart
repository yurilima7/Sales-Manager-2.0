import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/pages/client_data/client_data_state.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';
import 'package:sales_manager/app/repositories/user/user_repository.dart';

class ClientDataController extends Cubit<ClientDataState> {
  final SalesRepository _salesRepository;
  final ClientsRepository _clientsRepository;
  final UserRepository _userRepository;

  ClientDataController(
    this._salesRepository,
    this._clientsRepository,
    this._userRepository,
  ) : super(const ClientDataState.initial());

  Future<void> load(int id) async {
    emit(state.copyWith(status: ClientDataStatus.loading));

    try {
      final purchases = await _salesRepository.loadPurchasesClient(id);

      purchases.sort((product1, product2) => product2.day.compareTo(product1.day));

      emit(state.copyWith(
        status: ClientDataStatus.loaded,
        sales: purchases,
      ));
    } catch (e, s) {
      log('Erro ao buscar as compras do usuário', error: e, stackTrace: s);
      emit(state.copyWith(
        status: ClientDataStatus.error,
        errorMessage: 'Erro ao buscar as compras do usuário',
      ));
    }
  }

  Future<void> deleteClient(ClientModel clientModel) async {
    emit(state.copyWith(status: ClientDataStatus.deleting));

    try {
      final user = await _userRepository.loadUser();
      final userData = await _userRepository.loadUserData(user.id);
      final purchases = await _salesRepository.loadPurchasesClient(clientModel.id);

      _userRepository.updateValuesUser(
        userData.id,
        userData.recebido,
        userData.receber - clientModel.due,
        userData.totalVendido - clientModel.due,
      );

      for(int i = 0; i < purchases.length; i++) {
        _salesRepository.deletePurchaseClient(purchases[i].id);
      }

      _clientsRepository.deleteClient(clientModel.id);

      emit(state.copyWith(status: ClientDataStatus.deleted));
    } catch (e, s) {
      log('Erro ao deletar cliente', error: e, stackTrace: s);
      emit(state.copyWith(
        status: ClientDataStatus.error,
        errorMessage: 'Erro ao deletar cliente',
      ));
    }
  }
}
