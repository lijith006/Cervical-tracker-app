// import 'package:flutter/material.dart';
// import 'package:cervical_tracker/core/storage/hive_service.dart';
// import 'package:cervical_tracker/core/theme/app_colors.dart';
// import 'package:cervical_tracker/features/settings/view/settings_screen.dart';
// import 'package:cervical_tracker/features/traction/view/traction_screen.dart';
// import 'package:lottie/lottie.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     await Future.delayed(const Duration(seconds: 2));

//     final bool hasSetup = await HiveService.hasCompletedSetup();

//     if (!mounted) return;

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (_) =>
//             hasSetup ? const TractionScreen() : const SettingsScreen(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(gradient: AppColors.tractionBackground),

//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset(
//               'assets/animations/loading.json',
//               width: 220,
//               height: 220,
//               repeat: true,
//             ),

//             SizedBox(height: 20),

//             Text(
//               'Cervical Tracker',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.2,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// updated anim

import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/storage/hive_service.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';
import 'package:cervical_tracker/features/settings/view/settings_screen.dart';
import 'package:cervical_tracker/features/traction/view/traction_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    final bool hasSetup = await HiveService.hasCompletedSetup();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            hasSetup ? const TractionScreen() : const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.tractionBackground),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/loading.json',
              width: 220,
              height: 220,
              repeat: true,
            ),

            SizedBox(height: 20),

            Text(
              'Cervical Tracker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ).animate().fade(duration: 900.ms).slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }
}
