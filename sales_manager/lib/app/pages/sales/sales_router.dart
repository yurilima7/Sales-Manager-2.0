import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/models/sale_model.dart';
import 'package:sales_manager/app/pages/sales/sales.dart';

class SalesRouter {
  const SalesRouter._();

  static Widget get page => MultiProvider(
        providers: [
           Provider(
            create: (context) => null,
          ),
        ],

         builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments 
                    as List<SaleModel>;

          return Sales(
            sales: args,
          );
        },   
      );
}
