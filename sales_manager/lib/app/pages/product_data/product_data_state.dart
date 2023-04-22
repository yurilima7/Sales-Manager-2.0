import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:sales_manager/app/models/user_model.dart';

part 'product_data_state.g.dart';

@match
enum ProductDataStatus {
  initial,
  loading,
  loaded,
  updating,
  updated,
  deleting,
  deleted,
  error,
}

class ProductDataState extends Equatable {
  final ProductDataStatus status;
  final String? errorMessage;
  final UserModel? user;

  const ProductDataState({
    required this.status,
    this.errorMessage,
    this.user,
  });

  const ProductDataState.initial()
      : status = ProductDataStatus.initial,
        errorMessage = null,
        user = null;

  @override
  List<Object?> get props => [status, errorMessage];

  ProductDataState copyWith({
    ProductDataStatus? status,
    String? errorMessage,
    UserModel? user,
  }) {
    return ProductDataState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
