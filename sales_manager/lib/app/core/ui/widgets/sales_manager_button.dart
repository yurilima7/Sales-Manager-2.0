import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/button_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';

class SalesManagerButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  const SalesManagerButton({
    super.key,
    this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: context.buttonApp.button,
      child: Text(
        label,
        style: context.textApp.textPrimary,
      ),
    );
  }
}
