import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';

class UserCard extends StatelessWidget {
  final String name;

  const UserCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),

        child: ListTile(
          leading: Image.asset(
            'assets/images/User.png',
            height: 60,
          ),

          title: Text(
            'Olá $name',
            style: context.textApp.userCard,
          ),

          subtitle: Text(
            'Seja muito bem-vindo(a)!',
            style: context.textApp.littleTextPrimary
                .copyWith(
                  color: context.colors.secundary,
                ),
          ),
        ),
      ),
    );
  }
}
