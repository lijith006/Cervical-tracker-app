// import 'package:flutter/material.dart';
// import '../../cubit/traction_state.dart';

// class PhaseIndicator extends StatelessWidget {
//   final TractionPhase phase;

//   const PhaseIndicator({super.key, required this.phase});

//   @override
//   Widget build(BuildContext context) {
//     final _PhaseStyle style = _resolveStyle(context, phase);

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,

//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

//       decoration: BoxDecoration(
//         color: style.backgroundColor,
//         borderRadius: BorderRadius.circular(20),
//       ),

//       child: Text(
//         style.label,

//         style: TextStyle(
//           color: style.textColor,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }

//   _PhaseStyle _resolveStyle(BuildContext context, TractionPhase phase) {
//     switch (phase) {
//       case TractionPhase.idle:
//         return _PhaseStyle(
//           label: 'READY',
//           backgroundColor: Colors.grey.shade200,
//           textColor: Colors.grey.shade800,
//         );

//       case TractionPhase.traction:
//         return _PhaseStyle(
//           label: 'TRACTION',
//           backgroundColor: Colors.blue.shade100,
//           textColor: Colors.blue.shade800,
//         );

//       case TractionPhase.rest:
//         return _PhaseStyle(
//           label: 'REST',
//           backgroundColor: Colors.orange.shade100,
//           textColor: Colors.orange.shade800,
//         );

//       case TractionPhase.stopped:
//         return _PhaseStyle(
//           label: 'STOPPED',
//           backgroundColor: Colors.orange.shade100,
//           textColor: Colors.orange.shade800,
//         );

//       case TractionPhase.completed:
//         return _PhaseStyle(
//           label: 'COMPLETED',
//           backgroundColor: Colors.green.shade100,
//           textColor: Colors.green.shade800,
//         );
//     }
//   }
// }

// class _PhaseStyle {
//   final String label;
//   final Color backgroundColor;
//   final Color textColor;

//   const _PhaseStyle({
//     required this.label,
//     required this.backgroundColor,
//     required this.textColor,
//   });
// }

import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';
import '../../cubit/traction_state.dart';

class PhaseIndicator extends StatelessWidget {
  final TractionPhase phase;

  const PhaseIndicator({super.key, required this.phase});

  @override
  Widget build(BuildContext context) {
    final _PhaseStyle style = _resolveStyle(phase);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,

      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),

      decoration: BoxDecoration(
        color: style.backgroundColor,

        // borderRadius: BorderRadius.circular(30),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: style.backgroundColor.withOpacity(0.4),

            //  blurRadius: 12,
            blurRadius: 8,
          ),
        ],
      ),

      child: Text(
        style.label,

        style: TextStyle(
          color: style.textColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  _PhaseStyle _resolveStyle(TractionPhase phase) {
    switch (phase) {
      case TractionPhase.idle:
        return const _PhaseStyle(
          label: 'READY',
          backgroundColor: Colors.white12,
          textColor: Colors.white70,
        );

      case TractionPhase.traction:
        return const _PhaseStyle(
          label: 'TRACTION',
          backgroundColor: AppColors.tractionBg,
          textColor: AppColors.tractionText,
        );

      case TractionPhase.rest:
        return const _PhaseStyle(
          label: 'REST',
          backgroundColor: AppColors.restBg,
          textColor: AppColors.restText,
        );

      case TractionPhase.stopped:
        return const _PhaseStyle(
          label: 'STOPPED',
          backgroundColor: Color(0x33FF9800),
          textColor: Colors.orangeAccent,
        );

      case TractionPhase.completed:
        return const _PhaseStyle(
          label: 'COMPLETED',
          backgroundColor: Color(0x332ECC71),
          textColor: Colors.greenAccent,
        );
    }
  }
}

class _PhaseStyle {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const _PhaseStyle({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });
}
