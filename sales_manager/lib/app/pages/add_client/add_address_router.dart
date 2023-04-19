import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/core/rest_client/custom_dio.dart';
import 'package:sales_manager/app/pages/add_client/add_address.dart';
import 'package:sales_manager/app/pages/add_client/add_client_controller.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository_impl.dart';

class AddAddressRouter {
  AddAddressRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ClientsRepository>(
            create: (context) => ClientsRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),

          Provider(
            create: (context) =>
              AddClientController(
                context.read(),
              ),
          ),
        ],

        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments 
                    as List<String>;

          return AddAddress(
            clientData: args,
          );
        }, 
      );
}
