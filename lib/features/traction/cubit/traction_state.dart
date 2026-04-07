enum TractionPhase {
  idle, // before session starts
  traction, // 5-minute pull
  rest, // 5-second rest
  completed, // session finished
}

class TractionState {
  final TractionPhase phase;

  final int totalSecondsLeft; // starts at 1800
  final int phaseSecondsLeft; // 300 or 5

  final bool isRunning;

  const TractionState({
    required this.phase,
    required this.totalSecondsLeft,
    required this.phaseSecondsLeft,
    required this.isRunning,
  });

  factory TractionState.initial() {
    return const TractionState(
      phase: TractionPhase.idle,
      totalSecondsLeft: 0,
      phaseSecondsLeft: 0,
      isRunning: false,
    );
  }

  TractionState copyWith({
    TractionPhase? phase,
    int? totalSecondsLeft,
    int? phaseSecondsLeft,
    bool? isRunning,
  }) {
    return TractionState(
      phase: phase ?? this.phase,
      totalSecondsLeft: totalSecondsLeft ?? this.totalSecondsLeft,
      phaseSecondsLeft: phaseSecondsLeft ?? this.phaseSecondsLeft,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
