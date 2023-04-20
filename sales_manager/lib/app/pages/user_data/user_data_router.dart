import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/models/user_model.dart';
import 'package:sales_manager/app/pages/user_data/user_data.dart';

class UserDataRouter {
  UserDataRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => null,)
        ],

        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments 
                    as UserModel;

          return UserData(
            user: args,
          );
        },  
      );
}
