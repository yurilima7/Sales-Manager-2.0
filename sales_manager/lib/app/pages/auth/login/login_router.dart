import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_manager/app/pages/auth/login/login.dart';
import 'package:sales_manager/app/pages/auth/login/login_controller.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => LoginController(context.read()),),
        ],

        child: const Login(),
      );
}