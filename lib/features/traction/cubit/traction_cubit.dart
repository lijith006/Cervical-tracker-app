// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cervical_tracker/core/services/sound_service.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
// import 'traction_state.dart';
// import '../traction_constants.dart';

// class TractionCubit extends Cubit<TractionState> {
//   Timer? _timer;

//   TractionCubit() : super(TractionState.initial());

//   // ---------------------------
//   // Start Session
//   // ---------------------------
//   void startSession() {
//     WakelockPlus.enable();
//     SoundService.playSessionStart();
//     //SoundService.startTicking();

//     _timer?.cancel();

//     emit(
//       TractionState(
//         phase: TractionPhase.traction,
//         totalSecondsLeft: totalSessionSeconds,
//         phaseSecondsLeft: tractionPhaseSeconds,
//         isRunning: true,
//       ),
//     );

//     _startTimer();
//   }

//   // ---------------------------
//   // Pause Session
//   // ---------------------------
//   void pauseSession() {
//     if (!state.isRunning) return;
//     // SoundService.stopTicking();
//     WakelockPlus.disable();
//     SoundService.playPause();
//     _timer?.cancel();

//     emit(state.copyWith(isRunning: false));
//   }

//   // ---------------------------
//   // Resume Session
//   // ---------------------------
//   void resumeSession() {
//     if (state.isRunning || state.phase == TractionPhase.completed) return;
//     WakelockPlus.enable();

//     SoundService.playResume();
//     if (state.phase == TractionPhase.traction) {
//       // SoundService.startTicking();
//     }

//     emit(state.copyWith(isRunning: true));
//     _startTimer();
//   }

//   // ---------------------------
//   // Stop Session (manual)
//   // ---------------------------
//   void stopSession() {
//     _timer?.cancel();
//     WakelockPlus.disable();
//     SoundService.playSessionCompleted();

//     emit(
//       state.copyWith(
//         phase: TractionPhase.completed,
//         totalSecondsLeft: 0,
//         phaseSecondsLeft: 0,
//         isRunning: false,
//       ),
//     );
//   }

//   // ---------------------------
//   // Internal Timer Logic
//   // ---------------------------
//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       _onTick();
//     });
//   }

//   void _onTick() {
//     if (!state.isRunning) return;

//     final int newTotal = state.totalSecondsLeft - 1;
//     final int newPhase = state.phaseSecondsLeft - 1;

//     // ---------------------------
//     // Session complete (30 min)
//     // ---------------------------
//     if (newTotal <= 0) {
//       _timer?.cancel();
//       WakelockPlus.disable();
//       SoundService.playSessionCompleted();

//       emit(
//         state.copyWith(
//           phase: TractionPhase.completed,
//           totalSecondsLeft: 0,
//           phaseSecondsLeft: 0,
//           isRunning: false,
//         ),
//       );
//       return;
//     }

//     // ---------------------------
//     // Phase switch
//     // ---------------------------
//     if (newPhase <= 0) {
//       if (state.phase == TractionPhase.traction) {
//         // Traction → Rest (after 5 min)
//         //SoundService.stopTicking();
//         SoundService.playRestStart();

//         emit(
//           state.copyWith(
//             phase: TractionPhase.rest,
//             totalSecondsLeft: newTotal,
//             phaseSecondsLeft: restPhaseSeconds,
//           ),
//         );
//         // } else {
//         //   // Rest  Traction (after 10 sec)
//         //   SoundService.playTractionResume();
//         //   //SoundService.startTicking();

//         //   emit(
//         //     state.copyWith(
//         //       phase: TractionPhase.traction,
//         //       totalSecondsLeft: newTotal,
//         //       phaseSecondsLeft: tractionPhaseSeconds,
//         //     ),
//         //   );
//         // }
//       } else {
//         // Rest → Traction
//         SoundService.playTractionResume();

//         final int nextTractionSeconds = newTotal < tractionPhaseSeconds
//             ? newTotal
//             : tractionPhaseSeconds;

//         emit(
//           state.copyWith(
//             phase: TractionPhase.traction,
//             totalSecondsLeft: newTotal,
//             phaseSecondsLeft: nextTractionSeconds,
//           ),
//         );
//       }
//       return;
//     }

//     // ---------------------------
//     // Normal tick
//     // ---------------------------
//     emit(
//       state.copyWith(totalSecondsLeft: newTotal, phaseSecondsLeft: newPhase),
//     );
//   }

//   @override
//   Future<void> close() {
//     _timer?.cancel();
//     WakelockPlus.disable();
//     return super.close();
//   }
// }
// --------------------------------------
// new COde
//---------------------------------------

// import 'dart:async';
// import 'package:cervical_tracker/core/storage/hive_service.dart';
// import 'package:cervical_tracker/features/traction/models/traction_settings.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cervical_tracker/core/services/sound_service.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
// import 'traction_state.dart';

// class TractionCubit extends Cubit<TractionState> {
//   late TractionSettings _settings;

//   Timer? _timer;

//   TractionCubit() : super(TractionState.initial()) {
//     loadInitialSettings();
//   }
//   // ---------------------------
//   // Start Session
//   // ---------------------------
//   Future<void> startSession() async {
//     _settings = await HiveService.getSettings();
//     WakelockPlus.enable();
//     SoundService.playSessionStart();

//     _timer?.cancel();

//     emit(
//       TractionState(
//         phase: TractionPhase.traction,
//         totalSecondsLeft: _settings.totalSeconds,
//         phaseSecondsLeft: _settings.tractionSeconds,
//         initialTotalSeconds: _settings.totalSeconds,
//         isRunning: true,
//       ),
//     );

//     _startTimer();
//   }
//   // ---------------------------
//   // Load initial value
//   // ---------------------------

//   // Future<void> loadInitialSettings() async {
//   //   _settings = await HiveService.getSettings();

//   //   emit(
//   //     TractionState(
//   //       phase: TractionPhase.idle,
//   //       totalSecondsLeft: _settings.totalSeconds,
//   //       phaseSecondsLeft: _settings.tractionSeconds,
//   //       initialTotalSeconds: _settings.totalSeconds,
//   //       isRunning: false,
//   //     ),
//   //   );
//   // }
//   Future<void> loadInitialSettings() async {
//     _settings = await HiveService.getSettings();

//     if (state.isRunning) return;

//     emit(
//       state.copyWith(
//         totalSecondsLeft: _settings.totalSeconds,
//         phaseSecondsLeft: _settings.tractionSeconds,
//         initialTotalSeconds: _settings.totalSeconds,
//       ),
//     );
//   }

//   // ---------------------------
//   // Pause Session
//   // ---------------------------
//   void pauseSession() {
//     if (!state.isRunning) return;
//     WakelockPlus.disable();
//     SoundService.playPause();
//     _timer?.cancel();

//     emit(state.copyWith(isRunning: false));
//   }

//   // ---------------------------
//   // Resume Session
//   // ---------------------------
//   void resumeSession() {
//     if (state.isRunning || state.phase == TractionPhase.completed) return;
//     WakelockPlus.enable();

//     SoundService.playResume();
//     if (state.phase == TractionPhase.traction) {
//       // SoundService.startTicking();
//     }

//     emit(state.copyWith(isRunning: true));
//     _startTimer();
//   }

//   // ---------------------------
//   // Stop Session (manual)
//   // ---------------------------
//   void stopSession() {
//     _timer?.cancel();
//     WakelockPlus.disable();
//     SoundService.playSessionCompleted();

//     emit(
//       state.copyWith(
//         phase: TractionPhase.completed,
//         totalSecondsLeft: 0,
//         phaseSecondsLeft: 0,
//         isRunning: false,
//       ),
//     );
//   }

//   // ---------------------------
//   // Internal Timer Logic
//   // ---------------------------
//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       _onTick();
//     });
//   }

//   void _onTick() {
//     if (!state.isRunning) return;

//     final int newTotal = state.totalSecondsLeft - 1;
//     final int newPhase = state.phaseSecondsLeft - 1;

//     // ---------------------------
//     // Session complete (30 min)
//     // ---------------------------
//     if (newTotal <= 0) {
//       _timer?.cancel();
//       WakelockPlus.disable();
//       SoundService.playSessionCompleted();

//       emit(
//         state.copyWith(
//           phase: TractionPhase.completed,
//           totalSecondsLeft: 0,
//           phaseSecondsLeft: 0,
//           isRunning: false,
//         ),
//       );
//       return;
//     }

//     // ---------------------------
//     // Phase switch
//     // ---------------------------
//     if (newPhase <= 0) {
//       if (state.phase == TractionPhase.traction) {
//         // Traction → Rest (after 5 min)
//         //SoundService.stopTicking();
//         SoundService.playRestStart();

//         emit(
//           state.copyWith(
//             phase: TractionPhase.rest,
//             totalSecondsLeft: newTotal,

//             //final settings = await HiveService.getSettings();
//             phaseSecondsLeft: _settings.restSeconds,
//           ),
//         );
//       } else {
//         // Rest - Traction
//         SoundService.playTractionResume();

//         final int nextTractionSeconds = newTotal < _settings.tractionSeconds
//             ? newTotal
//             : _settings.tractionSeconds;

//         emit(
//           state.copyWith(
//             phase: TractionPhase.traction,
//             totalSecondsLeft: newTotal,
//             phaseSecondsLeft: nextTractionSeconds,
//           ),
//         );
//       }
//       return;
//     }

//     // ---------------------------
//     // Normal tick
//     // ---------------------------
//     emit(
//       state.copyWith(totalSecondsLeft: newTotal, phaseSecondsLeft: newPhase),
//     );
//   }

//   @override
//   Future<void> close() {
//     _timer?.cancel();
//     WakelockPlus.disable();
//     return super.close();
//   }
// }
//  Timer changed

// tima stamp timer changes  -real-time tracking system
import 'dart:async';

import 'package:cervical_tracker/core/services/sound_service.dart';
import 'package:cervical_tracker/core/storage/hive_service.dart';
import 'package:cervical_tracker/features/traction/models/traction_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'traction_state.dart';
import 'package:phone_state/phone_state.dart';

class TractionCubit extends Cubit<TractionState> {
  late TractionSettings _settings;

  Timer? _timer;

  // ---------------------------
  // REAL TIME TRACKING
  // ---------------------------

  DateTime? _sessionStartTime;
  DateTime? _phaseStartTime;

  int _pausedTotalSeconds = 0;
  int _pausedPhaseSeconds = 0;
  StreamSubscription<PhoneState>? _phoneStateSubscription;
  TractionCubit() : super(TractionState.initial()) {
    loadInitialSettings();
    _listenToPhoneCalls();
  }

  // ---------------------------
  // PHONE CALL LISTENER
  // ---------------------------

  void _listenToPhoneCalls() {
    _phoneStateSubscription = PhoneState.stream.listen((event) {
      final status = event.status;

      // Incoming call
      if (status == PhoneStateStatus.CALL_INCOMING) {
        autoPause();
      }

      // Active call
      if (status == PhoneStateStatus.CALL_STARTED) {
        autoPause();
      }
    });
  }

  // ---------------------------
  // START SESSION
  // ---------------------------

  Future<void> startSession() async {
    _settings = await HiveService.getSettings();

    WakelockPlus.enable();
    SoundService.playSessionStart();

    _timer?.cancel();

    // REAL TIMERS START
    _sessionStartTime = DateTime.now();
    _phaseStartTime = DateTime.now();

    emit(
      TractionState(
        phase: TractionPhase.traction,
        totalSecondsLeft: _settings.totalSeconds,
        phaseSecondsLeft: _settings.tractionSeconds,
        initialTotalSeconds: _settings.totalSeconds,
        isRunning: true,
      ),
    );

    _startTimer();
  }

  // ---------------------------
  // LOAD INITIAL SETTINGS
  // ---------------------------

  Future<void> loadInitialSettings() async {
    _settings = await HiveService.getSettings();

    if (state.isRunning) return;

    emit(
      state.copyWith(
        totalSecondsLeft: _settings.totalSeconds,
        phaseSecondsLeft: _settings.tractionSeconds,
        initialTotalSeconds: _settings.totalSeconds,
      ),
    );
  }

  // ---------------------------
  // PAUSE SESSION
  // ---------------------------

  void pauseSession() {
    if (!state.isRunning) return;

    WakelockPlus.disable();

    SoundService.playPause();

    _timer?.cancel();

    // SAVE REMAINING TIME
    _pausedTotalSeconds = state.totalSecondsLeft;
    _pausedPhaseSeconds = state.phaseSecondsLeft;

    emit(state.copyWith(isRunning: false));
  }
  // ---------------------------
  // AUTO PAUSE (PHONE CALL)
  // ---------------------------

  void autoPause() {
    if (!state.isRunning) return;

    pauseSession();
  }

  // ---------------------------
  // RESUME SESSION
  // ---------------------------

  void resumeSession() {
    if (state.isRunning || state.phase == TractionPhase.completed) {
      return;
    }

    WakelockPlus.enable();

    SoundService.playResume();

    // RESET REAL TIME STARTS
    _sessionStartTime = DateTime.now().subtract(
      Duration(seconds: state.initialTotalSeconds - _pausedTotalSeconds),
    );

    _phaseStartTime = DateTime.now().subtract(
      Duration(seconds: _getCurrentPhaseDuration() - _pausedPhaseSeconds),
    );

    emit(state.copyWith(isRunning: true));

    _startTimer();
  }

  // ---------------------------
  // STOP SESSION
  // ---------------------------

  void stopSession() {
    _timer?.cancel();

    WakelockPlus.disable();

    SoundService.playSessionCompleted();

    emit(
      state.copyWith(
        phase: TractionPhase.stopped,
        totalSecondsLeft: 0,
        phaseSecondsLeft: 0,
        isRunning: false,
      ),
    );
  }

  // ---------------------------
  // TIMER LOOP
  // ---------------------------

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _onTick());
  }

  // ---------------------------
  // REAL TIME TICK
  // ---------------------------

  void _onTick() {
    if (!state.isRunning) return;

    // TOTAL SESSION ELAPSED
    final totalElapsed = DateTime.now()
        .difference(_sessionStartTime!)
        .inSeconds;

    // PHASE ELAPSED
    final phaseElapsed = DateTime.now().difference(_phaseStartTime!).inSeconds;

    // REMAINING TIMES
    final int newTotal = _settings.totalSeconds - totalElapsed;

    final int currentPhaseDuration = _getCurrentPhaseDuration();

    final int newPhase = currentPhaseDuration - phaseElapsed;

    // ---------------------------
    // SESSION COMPLETED
    // ---------------------------

    if (newTotal <= 0) {
      _completeSession();
      return;
    }

    // ---------------------------
    // PHASE SWITCH
    // ---------------------------

    if (newPhase <= 0) {
      _switchPhase(newTotal);
      return;
    }

    // ---------------------------
    // NORMAL UPDATE
    // ---------------------------

    emit(
      state.copyWith(totalSecondsLeft: newTotal, phaseSecondsLeft: newPhase),
    );
  }

  // ---------------------------
  // SWITCH PHASE
  // ---------------------------

  void _switchPhase(int newTotal) {
    _phaseStartTime = DateTime.now();

    if (state.phase == TractionPhase.traction) {
      // TRACTION -> REST

      SoundService.playRestStart();

      emit(
        state.copyWith(
          phase: TractionPhase.rest,
          totalSecondsLeft: newTotal,
          phaseSecondsLeft: _settings.restSeconds,
        ),
      );
    } else {
      // REST -> TRACTION

      SoundService.playTractionResume();

      final int nextTractionSeconds = newTotal < _settings.tractionSeconds
          ? newTotal
          : _settings.tractionSeconds;

      emit(
        state.copyWith(
          phase: TractionPhase.traction,
          totalSecondsLeft: newTotal,
          phaseSecondsLeft: nextTractionSeconds,
        ),
      );
    }
  }

  // ---------------------------
  // COMPLETE SESSION
  // ---------------------------

  void _completeSession() {
    _timer?.cancel();

    WakelockPlus.disable();

    SoundService.playSessionCompleted();

    emit(
      state.copyWith(
        phase: TractionPhase.completed,
        totalSecondsLeft: 0,
        phaseSecondsLeft: 0,
        isRunning: false,
      ),
    );
  }

  // ---------------------------
  // CURRENT PHASE DURATION
  // ---------------------------

  int _getCurrentPhaseDuration() {
    return state.phase == TractionPhase.rest
        ? _settings.restSeconds
        : _settings.tractionSeconds;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _phoneStateSubscription?.cancel();

    WakelockPlus.disable();

    return super.close();
  }
}
