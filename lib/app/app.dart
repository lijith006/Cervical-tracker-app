import 'package:flutter/material.dart';
import '../features/traction/view/traction_screen.dart';

class CervicalTractionApp extends StatelessWidget {
  const CervicalTractionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cervical Traction Tracker',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const TractionScreen(),
    );
  }
}
