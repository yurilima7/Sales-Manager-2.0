import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:sales_manager/app/models/user_model.dart';

part 'register_sale_state.g.dart';

@match
enum RegisterSaleStatus {
  initial,
  registering,
  registered,
  loading,
  loaded,
  error,
}

class RegisterSaleState extends Equatable {
  final RegisterSaleStatus status;
  final String? errorMessage;
  final UserModel? user;

  const RegisterSaleState({
    required this.status,
    this.errorMessage,
    this.user,
  });

  const RegisterSaleState.initial()
      : status = RegisterSaleStatus.initial,
        errorMessage = null,
        user = null;

  @override
  List<Object?> get props => [status, errorMessage];

  RegisterSaleState copyWith({
    RegisterSaleStatus? status,
    String? errorMessage,
    UserModel? user,
  }) {
    return RegisterSaleState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
