import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/pages/update_client/update_client_state.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';

class UpdateClientController extends Cubit<UpdateClientState> {
  final ClientsRepository _clientsRepository;

  UpdateClientController(
    this._clientsRepository,
  ) : super(const UpdateClientState.initial());

  Future<void> updateClient(
    String id,
    String name,
    String phone,
    String district,
    String street,
    int number,
    double due,
  ) async {
    emit(state.copyWith(status: UpdateClientStatus.updating));

    try {
      _clientsRepository.updateClient(
        id,
        name,
        phone,
        district,
        street,
        number,
        due,
      );

      emit(state.copyWith(
        status: UpdateClientStatus.updated,
      ));
    } catch (e, s) {
      log('Erro ao atualizar cliente', error: e, stackTrace: s);
      emit(state.copyWith(
        status: UpdateClientStatus.error,
        errorMessage: 'Erro ao atualizar cliente',
      ));
    }
  }
}
