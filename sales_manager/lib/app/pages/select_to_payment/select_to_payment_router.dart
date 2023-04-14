import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/core/rest_client/custom_dio.dart';
import 'package:sales_manager/app/pages/select_to_payment/select_to_payment.dart';
import 'package:sales_manager/app/pages/select_to_payment/select_to_payment_controller.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository.dart';
import 'package:sales_manager/app/repositories/sales/sales_repository_impl.dart';

class SelectToPaymentRouter {
  SelectToPaymentRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<SalesRepository>(
            create: (context) => SalesRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),

          Provider(
          create: (context) =>
            SelectToPaymentController(
              context.read(),
            ),
        ),
        ],

        child: const SelectToPayment(),
           
      );
}
