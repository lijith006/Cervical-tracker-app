import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AppPageTransition<T> extends PageRouteBuilder<T> {
  final Widget page;

  AppPageTransition({required this.page})
    : super(
        transitionDuration: const Duration(milliseconds: 350),

        pageBuilder: (context, animation, secondaryAnimation) => page,

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      );
}
