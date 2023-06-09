import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_manager/app/core/ui/config/env/env.dart';
import 'package:sales_manager/app/sales_manager.dart';

Future<void> main() async {
  await Env.i.load();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(SalesManager());
}
