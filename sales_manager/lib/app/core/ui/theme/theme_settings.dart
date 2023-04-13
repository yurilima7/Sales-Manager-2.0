import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';

class ThemeSettings {
  ThemeSettings._();

  static final _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide.none
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: ColorsApp.i.primary,
    primaryColor: ColorsApp.i.primary,

    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.i.primary,
      primary: ColorsApp.i.primary,
      secondary: ColorsApp.i.secundary,
      tertiary: ColorsApp.i.tertiary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextApp.i.primaryRegular.copyWith(fontSize: 16),
      hintStyle: TextApp.i.primaryRegular.copyWith(fontSize: 16),
      enabledBorder: _defaultBorder,
      focusedBorder: _defaultBorder,
      focusedErrorBorder: _defaultBorder,
      errorBorder: _defaultBorder,
      filled: true,
      suffixIconColor: ColorsApp.i.primary,
      floatingLabelBehavior: FloatingLabelBehavior.never
    ),

     textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsApp.i.primary,
      selectionHandleColor: Colors.white70,
      selectionColor: Colors.white54,
    ),

    cardColor: ColorsApp.i.tertiary,
    cardTheme: CardTheme(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    )
  );
}
