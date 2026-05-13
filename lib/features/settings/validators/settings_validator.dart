// class SettingsValidator {
//   const SettingsValidator._();

//   static String? validate({
//     required int? totalMinutes,
//     required int? tractionMinutes,
//     required int? restSeconds,
//   }) {
//     // ---------------------------
//     // INVALID INPUT
//     // ---------------------------

//     if (totalMinutes == null ||
//         tractionMinutes == null ||
//         restSeconds == null) {
//       return 'Please enter valid numbers';
//     }

//     // ---------------------------
//     // POSITIVE VALUES
//     // ---------------------------

//     if (totalMinutes <= 0 || tractionMinutes <= 0 || restSeconds <= 0) {
//       return 'Values must be greater than zero';
//     }

//     // ---------------------------
//     // TOTAL SESSION LIMIT
//     // ---------------------------

//     if (totalMinutes < 5 || totalMinutes > 120) {
//       return 'Total session must be between 5 and 120 minutes';
//     }

//     // ---------------------------
//     // TRACTION LIMIT
//     // ---------------------------

//     if (tractionMinutes < 1 || tractionMinutes > 30) {
//       return 'Traction duration must be between 1 and 30 minutes';
//     }

//     // ---------------------------
//     // REST LIMIT
//     // ---------------------------

//     if (restSeconds < 3 || restSeconds > 60) {
//       return 'Rest duration must be between 3 and 60 seconds';
//     }

//     // ---------------------------
//     // LOGICAL VALIDATION
//     // ---------------------------

//     if (tractionMinutes > totalMinutes) {
//       return 'Traction duration cannot exceed total session';
//     }

//     return null;
//   }
// }

//
class SettingsValidator {
  static String? validate({
    required int totalMinutes,
    required int tractionMinutes,
    required int restSeconds,
  }) {
    // ---------------------------
    // MINIMUM VALUES
    // ---------------------------
    if (totalMinutes < 1) {
      return 'Total session must be at least 1 minute';
    }

    if (tractionMinutes < 1) {
      return 'Traction duration must be at least 1 minute';
    }

    if (restSeconds < 1) {
      return 'Rest duration must be at least 1 second';
    }

    // ---------------------------
    // MAXIMUM VALUES
    // ---------------------------
    if (totalMinutes > 180) {
      return 'Total session cannot exceed 180 minutes';
    }

    if (tractionMinutes > 60) {
      return 'Traction duration cannot exceed 60 minutes';
    }

    if (restSeconds > 60) {
      return 'Rest duration cannot exceed 60 seconds';
    }

    // ---------------------------
    // LOGICAL VALIDATION
    // ---------------------------
    if (tractionMinutes > totalMinutes) {
      return 'Traction duration must be less than total session';
    }

    return null;
  }
}
