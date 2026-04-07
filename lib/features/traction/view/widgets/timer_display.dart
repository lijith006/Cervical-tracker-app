import 'package:flutter/material.dart';
import '../../../../core/utils/time_formatter.dart';

class TimerDisplay extends StatelessWidget {
  final int seconds;
  final double fontSize;
  final Color? color;
  final bool verbose;

  const TimerDisplay({
    super.key,
    required this.seconds,
    this.fontSize = 48,
    this.color,
    this.verbose = false,
  });

  @override
  Widget build(BuildContext context) {
    final text = verbose
        ? TimeFormatter.formatMinSec(seconds)
        : TimeFormatter.formatMMSS(seconds);

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
