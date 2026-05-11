// import 'package:flutter/material.dart';
// import 'package:cervical_tracker/core/theme/app_colors.dart';

// class SessionProgressBar extends StatelessWidget {
//   final int totalSeconds;
//   final int remainingSeconds;

//   const SessionProgressBar({
//     super.key,
//     required this.totalSeconds,
//     required this.remainingSeconds,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final progress = 1 - (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Session Progress',
//           style: TextStyle(color: AppColors.mutedText, fontSize: 14),
//         ),
//         const SizedBox(height: 6),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: LinearProgressIndicator(
//             value: progress,
//             minHeight: 10,
//             backgroundColor: Colors.white12,
//             valueColor: const AlwaysStoppedAnimation(AppColors.primaryAccent),
//           ),
//         ),
//       ],
//     );
//   }
// }
//-------------------UPDATED CODE
// import 'package:flutter/material.dart';
// import 'package:cervical_tracker/core/theme/app_colors.dart';

// class SessionProgressBar extends StatelessWidget {
//   final int totalSeconds;
//   final int remainingSeconds;

//   const SessionProgressBar({
//     super.key,
//     required this.totalSeconds,
//     required this.remainingSeconds,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final progress = 1 - (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Session Progress',
//           style: TextStyle(color: AppColors.mutedText, fontSize: 14),
//         ),
//         const SizedBox(height: 6),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: LinearProgressIndicator(
//             value: progress,
//             minHeight: 10,
//             backgroundColor: Colors.white12,
//             valueColor: const AlwaysStoppedAnimation(AppColors.primaryAccent),
//           ),
//         ),
//       ],
//     );
//   }
// }
// ANIMATED  PROGRESS

// import 'package:flutter/material.dart';

// class SessionProgressBar extends StatelessWidget {
//   final int totalSeconds;
//   final int remainingSeconds;

//   const SessionProgressBar({
//     super.key,
//     required this.totalSeconds,
//     required this.remainingSeconds,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final progress = remainingSeconds / totalSeconds;

//     return TweenAnimationBuilder<double>(
//       tween: Tween<double>(begin: 0, end: progress),

//       duration: const Duration(milliseconds: 400),

//       builder: (context, value, child) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(30),

//           child: LinearProgressIndicator(
//             value: value,
//             minHeight: 12,
//             backgroundColor: Colors.white12,
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class SessionProgressBar extends StatelessWidget {
  final int totalSeconds;
  final int remainingSeconds;

  const SessionProgressBar({
    super.key,
    required this.totalSeconds,
    required this.remainingSeconds,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = totalSeconds <= 0
        ? 0
        : remainingSeconds / totalSeconds;

    // Keep value between 0 and 1
    final double safeProgress = progress.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),

      child: LinearProgressIndicator(
        value: safeProgress,
        minHeight: 12,

        backgroundColor: Colors.white12,

        valueColor: const AlwaysStoppedAnimation(Colors.white70),
      ),
    );
  }
}
