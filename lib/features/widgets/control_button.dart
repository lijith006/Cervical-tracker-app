// import 'package:flutter/material.dart';
// import 'package:cervical_tracker/core/theme/app_colors.dart';

// class ControlButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final bool primary;

//   const ControlButton({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     this.primary = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//         decoration: BoxDecoration(
//           gradient: primary
//               ? const LinearGradient(
//                   colors: [AppColors.primaryAccent, Color(0xFF5B7CFA)],
//                 )
//               : null,
//           color: primary ? null : Colors.white12,
//           borderRadius: BorderRadius.circular(50),
//           boxShadow: primary
//               ? [
//                   BoxShadow(
//                     color: AppColors.primaryAccent.withOpacity(0.4),
//                     blurRadius: 12,
//                     offset: const Offset(0, 6),
//                   ),
//                 ]
//               : null,
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, color: Colors.white),
//             const SizedBox(width: 8),
//             Text(
//               label,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//Updated Anim:
import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';

class ControlButton extends StatefulWidget {
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
  State<ControlButton> createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
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

        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),

          decoration: BoxDecoration(
            gradient: widget.primary
                ? const LinearGradient(
                    colors: [AppColors.primaryAccent, Color(0xFF5B7CFA)],
                  )
                : null,

            color: widget.primary ? null : Colors.white12,

            borderRadius: BorderRadius.circular(50),

            boxShadow: widget.primary
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
              Icon(widget.icon, color: Colors.white),

              const SizedBox(width: 8),

              Text(
                widget.label,

                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
