import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';

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
    final progress = 1 - (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Session Progress',
          style: TextStyle(color: AppColors.mutedText, fontSize: 14),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: Colors.white12,
            valueColor: const AlwaysStoppedAnimation(AppColors.primaryAccent),
          ),
        ),
      ],
    );
  }
}
