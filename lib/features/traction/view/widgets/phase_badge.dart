import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';
import '../../cubit/traction_state.dart';

class PhaseBadge extends StatelessWidget {
  final TractionPhase phase;

  const PhaseBadge({super.key, required this.phase});

  @override
  Widget build(BuildContext context) {
    final isRest = phase == TractionPhase.rest;

    final Color bgColor = isRest ? AppColors.restBg : AppColors.tractionBg;

    final Color textColor = isRest
        ? AppColors.restText
        : AppColors.tractionText;

    final IconData icon = isRest
        ? Icons.self_improvement
        : Icons.fitness_center;

    final String label = phase == TractionPhase.traction
        ? 'TRACTION'
        : phase == TractionPhase.rest
        ? 'REST'
        : phase.name.toUpperCase();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
