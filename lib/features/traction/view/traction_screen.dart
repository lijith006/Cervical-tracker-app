import 'package:cervical_tracker/core/theme/app_colors.dart';
import 'package:cervical_tracker/features/traction/cubit/traction_cubit.dart';
import 'package:cervical_tracker/features/traction/cubit/traction_state.dart';
import 'package:cervical_tracker/features/traction/view/widgets/control_buttons.dart';
import 'package:cervical_tracker/features/traction/view/widgets/phase_badge.dart';
import 'package:cervical_tracker/features/traction/view/widgets/timer_display.dart';
import 'package:cervical_tracker/features/widgets/session_progress_bar.dart';
import 'package:cervical_tracker/features/widgets/timer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TractionScreen extends StatelessWidget {
  const TractionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TractionCubit(),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // appBar: AppBar(
        //   title: const Text(
        //     'Traction Session',
        //     style: TextStyle(color: AppColors.mutedText),
        //   ),
        //   // backgroundColor: AppColors.darkBlue,
        //   backgroundColor: AppColors.darkBlue1,
        // ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.tractionBackground,
          ),
          child: SafeArea(
            child: BlocBuilder<TractionCubit, TractionState>(
              builder: (context, state) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Phase text
                      PhaseBadge(phase: state.phase),

                      const SizedBox(height: 12),

                      // Main Timer
                      TimerCard(
                        child: TimerDisplay(
                          seconds: state.totalSecondsLeft,
                          fontSize: 42,
                          verbose: true,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Progress bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SessionProgressBar(
                          totalSeconds: 1800, // 30 min
                          remainingSeconds: state.totalSecondsLeft,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Phase timer (secondary)
                      TimerDisplay(
                        seconds: state.phaseSecondsLeft,
                        fontSize: 20,
                        color: AppColors.mutedText,
                        verbose: true,
                      ),

                      const SizedBox(height: 28),

                      // Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ControlButtons(state: state)],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
