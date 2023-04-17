import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:sales_manager/app/models/sale_model.dart';

part 'payment_state.g.dart';

@match
enum PaymentStatus {
  initial,
  loading,
  loaded,
  error,
}

class PaymentState extends Equatable {
  final PaymentStatus status;
  final String? errorMessage;
  final List<SaleModel>? sales;

  const PaymentState({
    required this.status,
    this.errorMessage,
    this.sales,
  });

  const PaymentState.initial()
      : status = PaymentStatus.initial,
        sales = const [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  PaymentState copyWith({
    PaymentStatus? status,
    String? errorMessage,
    List<SaleModel>? sales,
  }) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      sales: sales ?? this.sales,
    );
  }
}
