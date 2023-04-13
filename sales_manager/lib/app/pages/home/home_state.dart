import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/models/sale_model.dart';
import 'package:sales_manager/app/models/user_model.dart';

part 'home_state.g.dart';

@match
enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final UserModel? user;
  final List<ClientModel>? clients;
  final List<SaleModel>? sales;

  const HomeState({
    required this.status,
    this.user,
    this.errorMessage,
    this.clients,
    this.sales,
  });

  const HomeState.initial()
      : status = HomeStatus.initial,
        user = null,
        errorMessage = null,
        clients = const [],
        sales = const [];

  @override
  List<Object?> get props => [status, errorMessage];


  HomeState copyWith({
    HomeStatus? status,
    UserModel? user,
    String? errorMessage,
    List<ClientModel>? clients,
    List<SaleModel>? sales,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      clients: clients ?? this.clients,
      sales: sales ?? this.sales,
    );
  }
}
