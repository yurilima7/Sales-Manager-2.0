import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/pages/payment/payment_state.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';
import 'package:sales_manager/app/repositories/user/user_repository.dart';

class PaymentController extends Cubit<PaymentState> {
  final UserRepository _userRepository;
  final SalesRepository _salesRepository;
  final ClientsRepository _clientsRepository;

  PaymentController(
    this._userRepository,
    this._salesRepository,
    this._clientsRepository,
  ) : super(const PaymentState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: PaymentStatus.loading));

    try {
      final user = await _userRepository.loadUser();
      final userData = await _userRepository.loadUserData(user.id);

      emit(state.copyWith(
        status: PaymentStatus.loaded,
        user: userData,
      ));
    } catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      emit(state.copyWith(
        status: PaymentStatus.error,
        errorMessage: 'Erro ao buscar usuário',
      ));
    }
  }

  Future<void> payment(
    int idSale,
    int idClient,
    int idUser,
    double valuePayment,
    double total,
    double dueClient,
    double recebido,
    double receber,
    double totalVendido,
  ) async {
    emit(state.copyWith(status: PaymentStatus.paying));

    try {
      if (valuePayment == total) {
        _salesRepository.deletePurchaseClient(idSale);

        _clientsRepository.updateDue(
          idClient.toString(),
          dueClient - valuePayment,
        );

        _userRepository.updateValuesUser(
          idUser,
          recebido + valuePayment,
          receber - valuePayment,
          totalVendido,
        );
      } else if (valuePayment < total && valuePayment > 0.0) {
        _salesRepository.paymentSale(idSale, total - valuePayment);

        _clientsRepository.updateDue(
          idClient.toString(),
          dueClient - valuePayment,
        );

        _userRepository.updateValuesUser(
          idUser,
          recebido + valuePayment,
          receber - valuePayment,
          totalVendido,
        );
      }

      emit(state.copyWith(status: PaymentStatus.paid));
    } catch (e, s) {
      log('Erro ao realizar o pagamento do cliente', error: e, stackTrace: s);
      emit(state.copyWith(
        status: PaymentStatus.error,
        errorMessage: 'Erro ao realizar o pagamento do cliente',
      ));
    }
  }
}
