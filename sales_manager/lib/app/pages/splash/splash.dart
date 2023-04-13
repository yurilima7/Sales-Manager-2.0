import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/widgets/sales_manager_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                  height: 160,
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            SalesManagerButton(
              label: 'Acessar',
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                
                if (!sp.containsKey('accessToken')) {
                  navigator.pushNamedAndRemoveUntil('/auth/login', (route) => false);
                } else {
                  navigator.pushNamedAndRemoveUntil('/home', (route) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
