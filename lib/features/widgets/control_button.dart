import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';

class ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool primary;

  const ControlButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          gradient: primary
              ? const LinearGradient(
                  colors: [AppColors.primaryAccent, Color(0xFF5B7CFA)],
                )
              : null,
          color: primary ? null : Colors.white12,
          borderRadius: BorderRadius.circular(50),
          boxShadow: primary
              ? [
                  BoxShadow(
                    color: AppColors.primaryAccent.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
