import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:sales_manager/app/models/user_model.dart';

part 'payment_state.g.dart';

@match
enum PaymentStatus {
  initial,
  loading,
  loaded,
  paying,
  paid,
  error,
}

class PaymentState extends Equatable {
  final PaymentStatus status;
  final String? errorMessage;
  final UserModel? user;

  const PaymentState({
    required this.status,
    this.errorMessage,
    this.user,
  });

  const PaymentState.initial()
      : status = PaymentStatus.initial,
        errorMessage = null,
        user = null;

  @override
  List<Object?> get props => [status, errorMessage];

  PaymentState copyWith({
    PaymentStatus? status,
    String? errorMessage,
    final UserModel? user,
  }) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
