// import 'package:cervical_tracker/core/animations/page_transition.dart';
// import 'package:cervical_tracker/core/theme/app_colors.dart';
// import 'package:cervical_tracker/features/settings/view/settings_screen.dart';
// import 'package:cervical_tracker/features/traction/cubit/traction_cubit.dart';
// import 'package:cervical_tracker/features/traction/cubit/traction_state.dart';
// import 'package:cervical_tracker/features/traction/view/widgets/control_buttons.dart';
// import 'package:cervical_tracker/features/traction/view/widgets/phase_indicator.dart';
// import 'package:cervical_tracker/features/traction/view/widgets/timer_display.dart';
// import 'package:cervical_tracker/features/widgets/session_progress_bar.dart';
// import 'package:cervical_tracker/features/widgets/timer_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class TractionScreen extends StatelessWidget {
//   const TractionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: AppColors.darkBlue1,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,

//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.white54),
//             onPressed: () {
//               HapticFeedback.lightImpact();

//               Navigator.push(
//                 context,
//                 // MaterialPageRoute(builder: (_) => const SettingsScreen()),
//                 AppPageTransition(page: const SettingsScreen()),
//               ).then((_) {
//                 context.read<TractionCubit>().loadInitialSettings();
//               });
//             },
//           ),
//         ],
//       ),

//       body: Container(
//         decoration: const BoxDecoration(gradient: AppColors.tractionBackground),
//         child: SafeArea(
//           child: BlocBuilder<TractionCubit, TractionState>(
//             builder: (context, state) {
//               return Center(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 24),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Phase text
//                         PhaseIndicator(phase: state.phase),

//                         const SizedBox(height: 24),

//                         // Main Timer
//                         TimerCard(
//                           phase: state.phase,
//                           child: TimerDisplay(
//                             seconds: state.totalSecondsLeft,
//                             fontSize: 42,
//                             verbose: true,
//                             color: Colors.white,
//                           ),
//                         ),

//                         const SizedBox(height: 32),

//                         // Progress bar
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 24),
//                           child: SessionProgressBar(
//                             totalSeconds: state.initialTotalSeconds,
//                             remainingSeconds: state.totalSecondsLeft,
//                           ),
//                         ),

//                         const SizedBox(height: 24),

//                         // Phase timer (secondary)
//                         TimerDisplay(
//                           seconds: state.phaseSecondsLeft,
//                           fontSize: 20,
//                           color: AppColors.mutedText,
//                           verbose: true,
//                         ),

//                         const SizedBox(height: 32),

//                         // Controls
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [ControlButtons(state: state)],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//upddated code :

import 'package:cervical_tracker/core/animations/page_transition.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';
import 'package:cervical_tracker/features/settings/view/settings_screen.dart';
import 'package:cervical_tracker/features/traction/cubit/traction_cubit.dart';
import 'package:cervical_tracker/features/traction/cubit/traction_state.dart';
import 'package:cervical_tracker/features/traction/view/widgets/completed_session_view.dart';
import 'package:cervical_tracker/features/traction/view/widgets/control_buttons.dart';
import 'package:cervical_tracker/features/traction/view/widgets/phase_indicator.dart';
import 'package:cervical_tracker/features/traction/view/widgets/timer_display.dart';
import 'package:cervical_tracker/features/widgets/session_progress_bar.dart';
import 'package:cervical_tracker/features/widgets/timer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TractionScreen extends StatelessWidget {
  const TractionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.darkBlue1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,

        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white54),
            onPressed: () {
              HapticFeedback.lightImpact();

              Navigator.push(
                context,
                // MaterialPageRoute(builder: (_) => const SettingsScreen()),
                AppPageTransition(page: const SettingsScreen()),
              ).then((_) {
                context.read<TractionCubit>().loadInitialSettings();
              });
            },
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.tractionBackground),
        child: SafeArea(
          child: BlocBuilder<TractionCubit, TractionState>(
            builder: (context, state) {
              if (state.phase == TractionPhase.completed) {
                return CompletedSessionView(state: state);
              }
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Phase text
                        PhaseIndicator(phase: state.phase),

                        const SizedBox(height: 24),

                        // Main Timer
                        TimerCard(
                          phase: state.phase,
                          child: TimerDisplay(
                            seconds: state.totalSecondsLeft,
                            fontSize: 42,
                            verbose: true,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Progress bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SessionProgressBar(
                            totalSeconds: state.initialTotalSeconds,
                            remainingSeconds: state.totalSecondsLeft,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Phase timer (secondary)
                        TimerDisplay(
                          seconds: state.phaseSecondsLeft,
                          fontSize: 20,
                          color: AppColors.mutedText,
                          verbose: true,
                        ),

                        const SizedBox(height: 32),

                        // Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ControlButtons(state: state)],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
