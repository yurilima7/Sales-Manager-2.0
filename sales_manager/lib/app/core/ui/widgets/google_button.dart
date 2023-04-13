import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      width: double.infinity,

      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4285F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Image.asset(
              'assets/images/google.png',
              height: 32,
            ),

            const SizedBox(
              width: 10,
            ),
            
            Text(
              'Login com o Google',
              style: context.textApp.primaryRegular.copyWith(
                fontSize: 16,
                color: context.colors.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
