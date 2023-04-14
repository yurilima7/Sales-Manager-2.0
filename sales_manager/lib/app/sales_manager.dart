import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/global/global_context.dart';
import 'package:sales_manager/app/core/provider/application_binding.dart';
import 'package:sales_manager/app/core/ui/theme/theme_settings.dart';
import 'package:sales_manager/app/pages/auth/login/login_router.dart';
import 'package:sales_manager/app/pages/auth/register/register_router.dart';
import 'package:sales_manager/app/pages/client_data/client_data_router.dart';
import 'package:sales_manager/app/pages/clients/client_router.dart';
import 'package:sales_manager/app/pages/select_to_payment/select_to_payment_router.dart';
import 'package:sales_manager/app/pages/splash/splash.dart';
import 'package:sales_manager/app/pages/home/home_router.dart';

class SalesManager extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  SalesManager({super.key}) {
    GlobalContext.i.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Sales Manager',
        theme: ThemeSettings.theme,
        debugShowCheckedModeBanner: false,
        navigatorKey: _navKey,
        routes: {
          '/': (context) => const Splash(),
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/home': (context) => HomeRouter.page,
          '/clients': (context) => ClientRouter.page,
          '/clientData': (context) => ClientDataRouter.page,
          '/selPayment': (context) => SelectToPaymentRouter.page,
        },
      ),
    );
  }
}
