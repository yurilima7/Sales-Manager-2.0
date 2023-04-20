import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/core/rest_client/custom_dio.dart';
import 'package:sales_manager/app/pages/update_client/update_address.dart';
import 'package:sales_manager/app/pages/update_client/update_client_controller.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository_impl.dart';

class UpdateAddressRouter {
  UpdateAddressRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ClientsRepository>(
            create: (context) => ClientsRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),

          Provider(
            create: (context) =>
              UpdateClientController(
                context.read(),
              ),
          ),
        ],

        child: const UpdateAddress(),
      );
}