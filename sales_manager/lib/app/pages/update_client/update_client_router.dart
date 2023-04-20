import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/pages/update_client/update_client.dart';

class UpdateClientRouter {
  UpdateClientRouter._();

  static Widget get page => MultiProvider(
        providers: [
           Provider(
            create: (context) => null,
          ),
        ],

        child: const UpdateClient(), 
      );
}
