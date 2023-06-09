import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';

class Input extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final bool obscureText;
  final bool fillColor;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;

  Input({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false, 
    this.fillColor = false,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.initialValue,
    this.onSaved, 
    this.inputFormatters,
  }) : obscureTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,

      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          obscureText: obscureTextValue,
          validator: validator,
          initialValue: initialValue,
          onSaved: onSaved,
          inputFormatters: inputFormatters,
        
          style: context.textApp.textPrimary.copyWith(color: Colors.black),
        
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            fillColor: fillColor ? Colors.white : context.colors.tertiary,
            suffixIcon:
                isPassword ?
                  IconButton(
                    onPressed: () => obscureTextVN.value = !obscureTextValue, 
                    icon: obscureTextValue ?
                      const Icon(Icons.visibility_outlined) 
                        : const Icon(Icons.visibility_off_outlined),
                  ) 
                  : null,
          ),
        );
      });
  }
}
