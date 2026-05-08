class TractionSettings {
  final int tractionSeconds;
  final int restSeconds;
  final int totalSeconds;

  TractionSettings({
    required this.tractionSeconds,
    required this.restSeconds,
    required this.totalSeconds,
  });

  factory TractionSettings.defaultSettings() {
    return TractionSettings(
      tractionSeconds: 300,
      restSeconds: 10,
      totalSeconds: 1800,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'traction': tractionSeconds,
      'rest': restSeconds,
      'total': totalSeconds,
    };
  }

  factory TractionSettings.fromMap(Map map) {
    return TractionSettings(
      tractionSeconds: map['traction'],
      restSeconds: map['rest'],
      totalSeconds: map['total'],
    );
  }
}
