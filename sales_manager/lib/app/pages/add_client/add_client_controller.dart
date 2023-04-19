import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/pages/add_client/add_client_state.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';

class AddClientController extends Cubit<AddClientState> {
  final ClientsRepository _clientsRepository;

  AddClientController(
    this._clientsRepository,
  ) : super(const AddClientState.initial());

  Future<void> registerClient(
    String name,
    String phone,
    String district,
    String street,
    int number,
  ) async {
    emit(state.copyWith(status: AddClientStatus.registering));

    try {
      _clientsRepository.addClient(
        name,
        phone,
        district,
        street,
        number,
        0.0,
        '#userAuthRef',
      );

      emit(state.copyWith(
        status: AddClientStatus.registered,
      ));
    } catch (e, s) {
      log('Erro ao cadastrar cliente', error: e, stackTrace: s);
      emit(state.copyWith(
        status: AddClientStatus.error,
        errorMessage: 'Erro ao cadastrar cliente',
      ));
    }
  }
}
