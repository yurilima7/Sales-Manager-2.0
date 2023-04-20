import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel? user;
  final VoidCallback? onPressed;

  const UserCard({
    super.key,
    this.user,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),

        child: ListTile(
          onTap: () => Navigator.of(context).pushNamed('/userData', arguments: user),
          leading: Image.asset(
            'assets/images/User.png',
            height: 60,
          ),

          title: Text(
            'Olá ${user?.name}',
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
