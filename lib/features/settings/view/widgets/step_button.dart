import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StepButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final Color accentColor;
  final VoidCallback? onTap;

  const StepButton({
    super.key,
    required this.icon,
    required this.enabled,
    required this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: () {
        if (enabled) {
          HapticFeedback.selectionClick();
          onTap?.call();
        }
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),

        width: 36,
        height: 36,

        decoration: BoxDecoration(
          color: enabled
              ? accentColor.withOpacity(0.15)
              : Colors.white.withOpacity(0.04),

          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color: enabled
                ? accentColor.withOpacity(0.3)
                : Colors.white.withOpacity(0.06),
          ),
        ),

        child: Icon(
          icon,
          size: 18,
          color: enabled ? accentColor : Colors.white24,
        ),
      ),
    );
  }
}
