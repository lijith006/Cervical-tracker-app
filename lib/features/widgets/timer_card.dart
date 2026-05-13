// import 'dart:ui';
// import 'package:flutter/material.dart';

// class TimerCard extends StatelessWidget {
//   final Widget child;

//   const TimerCard({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.12),
//             borderRadius: BorderRadius.circular(50),
//             border: Border.all(color: Colors.white24),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
// //updated anim:

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';
import 'package:cervical_tracker/features/traction/cubit/traction_state.dart';

class TimerCard extends StatelessWidget {
  final Widget child;
  final TractionPhase phase;

  const TimerCard({super.key, required this.child, required this.phase});

  @override
  Widget build(BuildContext context) {
    Color glowColor;

    switch (phase) {
      case TractionPhase.traction:
        glowColor = AppColors.primaryAccent;
        break;

      case TractionPhase.rest:
        glowColor = Colors.tealAccent;
        break;

      case TractionPhase.completed:
        glowColor = Colors.greenAccent;
        // glowColor = AppColors.tractionText;
        break;

      case TractionPhase.stopped:
        glowColor = Colors.orangeAccent;
        break;

      case TractionPhase.idle:
        glowColor = Colors.white24;
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,

      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),

      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(60),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(40),
        ),
        color: Colors.white10,

        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.35),

            // blurRadius: 25,
            // spreadRadius: 3,
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

          child: child,
        ),
      ),
    );
  }
}
