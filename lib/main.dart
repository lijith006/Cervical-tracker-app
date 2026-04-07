import 'package:flutter/material.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Later:
  // await Hive.initFlutter();
  // await HiveService.init();

  runApp(const CervicalTractionApp());
}
