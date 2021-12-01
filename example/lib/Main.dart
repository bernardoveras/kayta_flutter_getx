import 'package:flutter/material.dart';
import 'Initializer.dart';
import 'Routes.dart';
import 'BaseApp.dart';

void main() async {
  await Initializer.init();

  runApp(BaseApp(initialRoute: Routes.initialRoute));
}
