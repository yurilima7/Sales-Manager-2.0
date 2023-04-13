import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/pages/home/home_state.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';
import 'package:sales_manager/app/repositories/user/user_repository.dart';

class HomeController extends Cubit<HomeState> {
  final UserRepository _userRepository;
  final ClientsRepository _clientsRepository;
  final SalesRepository _salesRepository;

  HomeController(
    this._userRepository,
    this._clientsRepository,
    this._salesRepository,
  ) : super(const HomeState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final user = await _userRepository.loadUser();
      final clients = await _clientsRepository.loadClients();
      final sales = await _salesRepository.loadSales();

      emit(state.copyWith(
        status: HomeStatus.loaded,
        user: user,
        clients: clients,
        sales: sales,
      ));
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Erro ao buscar dados',
        ),
      );
    }
  }
}
