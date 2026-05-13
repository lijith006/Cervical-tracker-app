// import 'package:animations/animations.dart';
// import 'package:cervical_tracker/core/theme/app_colors.dart';
// import 'package:flutter/material.dart';

// class AppPageTransition<T> extends PageRouteBuilder<T> {
//   final Widget page;

//   AppPageTransition({required this.page})
//     : super(
//         opaque: false,

//         transitionDuration: const Duration(milliseconds: 350),

//         reverseTransitionDuration: const Duration(milliseconds: 350),

//         pageBuilder: (context, animation, secondaryAnimation) {
//           return page;
//         },

//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return Container(
//             decoration: const BoxDecoration(
//               gradient: AppColors.tractionBackground,
//             ),

//             child: FadeThroughTransition(
//               animation: animation,
//               secondaryAnimation: secondaryAnimation,
//               child: child,
//             ),
//           );
//         },
//       );
// }

import 'package:cervical_tracker/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppPageTransition<T> extends PageRouteBuilder<T> {
  final Widget page;

  AppPageTransition({required this.page})
    : super(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 420),
        reverseTransitionDuration: const Duration(milliseconds: 380),

        pageBuilder: (context, animation, secondaryAnimation) => page,

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Incoming: fade in + rise up slightly
          final fadeIn = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );

          final slideIn =
              Tween<Offset>(
                begin: const Offset(
                  0,
                  0.04,
                ), // very subtle — just 4% of screen height
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              );

          // Outgoing screen: fade out very slightly
          final fadeOut = Tween<double>(begin: 1.0, end: 0.92).animate(
            CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeIn),
          );

          return FadeTransition(
            opacity: fadeOut,
            child: SlideTransition(
              position: slideIn,
              child: FadeTransition(
                opacity: fadeIn,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.tractionBackground,
                  ),
                  child: child,
                ),
              ),
            ),
          );
        },
      );
}
