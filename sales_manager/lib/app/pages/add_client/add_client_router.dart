import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/pages/add_client/add_client.dart';

class AddClientRouter {
  AddClientRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => null,
          ),
          
        ],

        child: const AddClient(),
      );
}
