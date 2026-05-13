import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';

class ControlButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool primary;

  final Color? backgroundColor;
  final Color? foregroundColor;

  const ControlButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.primary = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  State<ControlButton> createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        widget.backgroundColor ?? (widget.primary ? null : Colors.white12);

    final fgColor = widget.foregroundColor ?? Colors.white;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },

      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
      },

      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },

      onTap: widget.onTap,

      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        scale: _pressed ? 0.96 : 1,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),

          decoration: BoxDecoration(
            gradient: widget.primary && widget.backgroundColor == null
                ? const LinearGradient(
                    colors: [AppColors.primaryAccent, Color(0xFF5B7CFA)],
                  )
                : null,

            color: bgColor,

            //borderRadius: BorderRadius.circular(50),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: widget.primary && widget.backgroundColor == null
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
              Icon(widget.icon, color: fgColor),

              const SizedBox(width: 8),

              Text(
                widget.label,

                style: TextStyle(color: fgColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
