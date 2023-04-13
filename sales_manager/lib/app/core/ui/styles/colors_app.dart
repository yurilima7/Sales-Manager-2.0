import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();
  static ColorsApp get i {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => const Color(0XFF6D3F8C);
  Color get secundary => const Color(0XFF734D8C);
  Color get tertiary => const Color(0XFFF2D9D0);
  Color get colorWhite => const Color(0XFFE7DCF2);
}

extension ColorAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.i;
}
