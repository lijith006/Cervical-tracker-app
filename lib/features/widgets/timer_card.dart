import 'dart:ui';
import 'package:flutter/material.dart';

class TimerCard extends StatelessWidget {
  final Widget child;

  const TimerCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white24),
          ),
          child: child,
        ),
      ),
    );
  }
}
