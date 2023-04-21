import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';

class TextApp {
  static TextApp? _instance;

  TextApp._();
  static TextApp get i {
    _instance ??= TextApp._();
    return _instance!;
  }

  String get fontPrimary => 'Archivo';
  String get fontSecondary => 'BebasNeue';
  String get fontTertiary => 'Audiowide';

  TextStyle get primaryRegular => TextStyle(
        color: ColorsApp.i.secundary,
        fontFamily: fontPrimary,
        fontWeight: FontWeight.w400,
      );

  TextStyle get primarySemiBold => TextStyle(
        color: ColorsApp.i.secundary,
        fontFamily: fontPrimary,
        fontWeight: FontWeight.w600,
      );

  TextStyle get appBarRegular => TextStyle(
        color: ColorsApp.i.tertiary,
        fontFamily: fontSecondary,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );

  TextStyle get appBarHome => TextStyle(
        color: ColorsApp.i.tertiary,
        fontFamily: fontTertiary,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );

  TextStyle get userCard => TextStyle(
        color: ColorsApp.i.secundary,
        fontFamily: fontSecondary,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );

  TextStyle get textCardTitle => TextStyle(
        color: ColorsApp.i.secundary,
        fontFamily: fontPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );

  TextStyle get textPrimary => primaryRegular.copyWith(
        fontSize: 16,
        color: ColorsApp.i.secundary,
      );

  TextStyle get textPrimaryLight => primaryRegular.copyWith(
        fontSize: 16,
        color: ColorsApp.i.tertiary,
      );

  TextStyle get littleTextPrimary => primaryRegular.copyWith(
        fontSize: 12,
        color: ColorsApp.i.tertiary,
      );
}

extension TextAppExtensions on BuildContext {
  TextApp get textApp => TextApp.i;
}
