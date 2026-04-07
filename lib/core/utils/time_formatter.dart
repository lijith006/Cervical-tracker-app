class TimeFormatter {
  const TimeFormatter._();

  /// MM:SS format (used if needed later)
  static String formatMMSS(int totalSeconds) {
    if (totalSeconds <= 0) return '00:00';

    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  /// Human readable format
  static String formatMinSec(int totalSeconds) {
    if (totalSeconds <= 0) return '0 min 0 sec';

    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    if (minutes == 0) {
      return '$seconds sec';
    }

    return '$minutes min $seconds sec';
  }
}
