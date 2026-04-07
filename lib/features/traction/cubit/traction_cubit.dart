import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cervical_tracker/core/services/sound_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'traction_state.dart';
import '../traction_constants.dart';

class TractionCubit extends Cubit<TractionState> {
  Timer? _timer;

  TractionCubit() : super(TractionState.initial());

  // ---------------------------
  // Start Session
  // ---------------------------
  void startSession() {
    WakelockPlus.enable();
    SoundService.playSessionStart();
    //SoundService.startTicking();

    _timer?.cancel();

    emit(
      TractionState(
        phase: TractionPhase.traction,
        totalSecondsLeft: totalSessionSeconds,
        phaseSecondsLeft: tractionPhaseSeconds,
        isRunning: true,
      ),
    );

    _startTimer();
  }

  // ---------------------------
  // Pause Session
  // ---------------------------
  void pauseSession() {
    if (!state.isRunning) return;
    // SoundService.stopTicking();
    WakelockPlus.disable();
    SoundService.playPause();
    _timer?.cancel();

    emit(state.copyWith(isRunning: false));
  }

  // ---------------------------
  // Resume Session
  // ---------------------------
  void resumeSession() {
    if (state.isRunning || state.phase == TractionPhase.completed) return;
    WakelockPlus.enable();

    SoundService.playResume();
    if (state.phase == TractionPhase.traction) {
      // SoundService.startTicking();
    }

    emit(state.copyWith(isRunning: true));
    _startTimer();
  }

  // ---------------------------
  // Stop Session (manual)
  // ---------------------------
  void stopSession() {
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
  // Internal Timer Logic
  // ---------------------------
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _onTick();
    });
  }

  void _onTick() {
    if (!state.isRunning) return;

    final int newTotal = state.totalSecondsLeft - 1;
    final int newPhase = state.phaseSecondsLeft - 1;

    // ---------------------------
    // Session complete (30 min)
    // ---------------------------
    if (newTotal <= 0) {
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
      return;
    }

    // ---------------------------
    // Phase switch
    // ---------------------------
    if (newPhase <= 0) {
      if (state.phase == TractionPhase.traction) {
        // Traction → Rest (after 5 min)
        //SoundService.stopTicking();
        SoundService.playRestStart();

        emit(
          state.copyWith(
            phase: TractionPhase.rest,
            totalSecondsLeft: newTotal,
            phaseSecondsLeft: restPhaseSeconds,
          ),
        );
      } else {
        // Rest  Traction (after 10 sec)
        SoundService.playTractionResume();
        //SoundService.startTicking();

        emit(
          state.copyWith(
            phase: TractionPhase.traction,
            totalSecondsLeft: newTotal,
            phaseSecondsLeft: tractionPhaseSeconds,
          ),
        );
      }
      return;
    }

    // ---------------------------
    // Normal tick
    // ---------------------------
    emit(
      state.copyWith(totalSecondsLeft: newTotal, phaseSecondsLeft: newPhase),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    WakelockPlus.disable();
    return super.close();
  }
}
