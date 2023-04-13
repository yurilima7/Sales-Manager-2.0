import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/pages/clients/client.dart';

class ClientRouter {
  ClientRouter._();

  static Widget get page => MultiProvider(
        providers: [
           Provider(
            create: (context) => null,
          ),
        ],

         builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments 
                    as List<ClientModel>;

          return Client(clients: args,);
        },   
      );
}
