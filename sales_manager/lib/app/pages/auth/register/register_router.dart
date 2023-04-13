import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/pages/auth/register/register.dart';
import 'package:sales_manager/app/pages/auth/register/register_controller.dart';

class RegisterRouter {
  RegisterRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => RegisterController(context.read()),),
        ],

        child: const Register(),
      );
}
