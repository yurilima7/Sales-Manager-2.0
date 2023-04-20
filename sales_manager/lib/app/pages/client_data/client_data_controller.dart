import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/models/user_model.dart';
import 'package:sales_manager/app/pages/client_data/client_data_state.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';

class ClientDataController extends Cubit<ClientDataState> {
  final SalesRepository _salesRepository;
  final ClientsRepository _clientsRepository;

  ClientDataController(
    this._salesRepository,
    this._clientsRepository,
  ) : super(const ClientDataState.initial());

  Future<void> load(int id) async {
    emit(state.copyWith(status: ClientDataStatus.loading));

    try {
      final purchases = await _salesRepository.loadPurchasesClient(id);

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

  Future<void> deleteClient(ClientModel clientModel, UserModel user) async {
    emit(state.copyWith(status: ClientDataStatus.deleting));

    try {
      _clientsRepository.deleteClient(clientModel.id);
      
    } catch (e, s) {
      log('Erro ao deletar cliente', error: e, stackTrace: s);
      emit(state.copyWith(
        status: ClientDataStatus.error,
        errorMessage: 'Erro ao deletar cliente',
      ));
    }
  }
}
