import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/core/rest_client/custom_dio.dart';
import 'package:sales_manager/app/pages/product_data/product_data.dart';
import 'package:sales_manager/app/pages/product_data/product_data_controller.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository.dart';
import 'package:sales_manager/app/repositories/clients/clients_repository_impl.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository_impl.dart';
import 'package:sales_manager/app/repositories/user/user_repository.dart';
import 'package:sales_manager/app/repositories/user/user_repository_impl.dart';

class ProductDataRouter {
  const ProductDataRouter._();

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
              ProductDataController(
                context.read(),
                context.read(),
                context.read(),
              ),
          ),
        ],

        child: const ProductData(),
      );
}
