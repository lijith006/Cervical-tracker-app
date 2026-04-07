// import 'package:flutter/material.dart';

// class AppColors {
//   // Solid colors

//   static const Color darkBlue = Color(0xFF0D1B2A);
//   static const Color navyBlue = Color(0xFF1B263B);
//   static const Color steelBlue = Color(0xFF415A77);
//   static const Color lightBlue = Color(0xFF778DA9);

//   // Text colors
//   static const Color primaryText = Colors.white;
//   static const Color secondaryText = Color(0xFFCBD5E1);

//   static const LinearGradient tractionBackground = LinearGradient(
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//     colors: [Color.fromARGB(255, 51, 70, 105), darkBlue],
//   );
// }
import 'package:flutter/material.dart';

class AppColors {
  static const Gradient tractionBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0A1A2F), // deep navy
      Color(0xFF102A43), // blue
      Color(0xFF1B3A5F), // lighter blue
    ],
  );

  static const Color primaryAccent = Color(0xFF7C9EFF);
  static const Color lightText = Colors.white;
  static const Color mutedText = Colors.white70;

  static const Color darkBlue = Color(0xFF0D1B2A);
  static const Color navyBlue = Color(0xFF1B263B);
  static const Color steelBlue = Color(0xFF415A77);
  static const Color lightBlue = Color(0xFF778DA9);

  // Phase colors
  static const tractionBg = Color(0x332196F3); // soft blue
  static const tractionText = Color(0xFF90CAF9);

  static const restBg = Color.fromARGB(115, 184, 218, 121); // teal calm

  static const restText = Color(0xFF80DEEA);
}
