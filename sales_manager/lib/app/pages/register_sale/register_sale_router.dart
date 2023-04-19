import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/core/rest_client/custom_dio.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/pages/register_sale/register_sale.dart';
import 'package:sales_manager/app/pages/register_sale/register_sale_controller.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository_impl.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository_impl.dart';
import 'package:sales_manager/app/repositories/user/user_repository.dart';
import 'package:sales_manager/app/repositories/user/user_repository_impl.dart';

class RegisterSaleRouter {
  RegisterSaleRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<SalesRepository>(
            create: (context) => SalesRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),

          Provider<UserRepository>(
            create: (context) => UserRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),

          Provider<ClientsRepository>(
            create: (context) => ClientsRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),

          Provider(
            create: (context) =>
              RegisterSaleController(
                context.read(),
                context.read(),
                context.read(),
              ),
          ),
        ],

        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments 
                    as ClientModel;
          return RegisterSale(
            clientModel: args,
          );
        },
      );
}
