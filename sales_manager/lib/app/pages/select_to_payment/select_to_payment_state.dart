import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:sales_manager/app/models/sale_model.dart';

part 'select_to_payment_state.g.dart';

@match
enum SelectToPaymentStatus {
  initial,
  loading,
  loaded,
  error,
}

class SelectToPaymentState extends Equatable {
  final SelectToPaymentStatus status;
  final String? errorMessage;
  final List<SaleModel>? sales;

  const SelectToPaymentState({
    required this.status,
    this.errorMessage,
    this.sales,
  });

  const SelectToPaymentState.initial()
      : status = SelectToPaymentStatus.initial,
        sales = const [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  SelectToPaymentState copyWith({
    SelectToPaymentStatus? status,
    String? errorMessage,
    List<SaleModel>? sales,
  }) {
    return SelectToPaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      sales: sales ?? this.sales,
    );
  }
}
