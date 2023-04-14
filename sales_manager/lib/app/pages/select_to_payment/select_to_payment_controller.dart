import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:sales_manager/app/pages/select_to_payment/select_to_payment_state.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';

class SelectToPaymentController extends Cubit<SelectToPaymentState> {
  final SalesRepository _salesRepository;

  SelectToPaymentController(
    this._salesRepository,
  ) : super(const SelectToPaymentState.initial());

  Future<void> load(int id) async {
    emit(state.copyWith(status: SelectToPaymentStatus.loading));

    try {
      final purchases = await _salesRepository.loadPurchasesClient(id);

      emit(state.copyWith(
        status: SelectToPaymentStatus.loaded,
        sales: purchases,
      ));
    } catch (e, s) {
      log('Erro ao buscar as compras do cliente', error: e, stackTrace: s);
      emit(state.copyWith(
        status: SelectToPaymentStatus.error,
        errorMessage: 'Erro ao buscar as compras do cliente',
      ));
    }
  }
}
