import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:sales_manager/app/models/sale_model.dart';

part 'client_data_state.g.dart';

@match
enum ClientDataStatus {
  initial,
  loading,
  loaded,
  error,
  deleting,
  deleted,
}

class ClientDataState extends Equatable {
  final ClientDataStatus status;
  final String? errorMessage;
  final List<SaleModel>? sales;

  const ClientDataState({
    required this.status,
    this.errorMessage,
    this.sales,
  });

  const ClientDataState.initial()
      : status = ClientDataStatus.initial,
        sales = const [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  ClientDataState copyWith({
    ClientDataStatus? status,
    String? errorMessage,
    List<SaleModel>? sales,
  }) {
    return ClientDataState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      sales: sales ?? this.sales,
    );
  }
}
