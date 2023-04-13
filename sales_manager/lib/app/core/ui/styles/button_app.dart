import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';

class ButtonApp {
  static ButtonApp? _instance;

  ButtonApp._();
  static ButtonApp get i {
    _instance ??= ButtonApp._();
    return _instance!;
  }

  ButtonStyle get button => ElevatedButton.styleFrom(
        backgroundColor: ColorsApp.i.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: TextApp.i.primaryRegular.copyWith(fontSize: 16),
        minimumSize: const Size(152, 57)
      );

  ButtonStyle get buttonLight => ElevatedButton.styleFrom(
        backgroundColor: ColorsApp.i.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: TextApp.i.primaryRegular.copyWith(fontSize: 16),
        minimumSize: const Size(152, 57)
      );
}

extension ButtonAppExtension on BuildContext {
  ButtonApp get buttonApp => ButtonApp.i;
}
