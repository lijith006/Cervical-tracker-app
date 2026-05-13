// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../cubit/traction_cubit.dart';
// import '../../cubit/traction_state.dart';
// import '../../../widgets/control_button.dart';

// class ControlButtons extends StatelessWidget {
//   final TractionState state;

//   const ControlButtons({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<TractionCubit>();

//     // ---------------------------
//     // IDLE - Start
//     // ---------------------------
//     if (state.phase == TractionPhase.idle) {
//       return ControlButton(
//         icon: Icons.play_arrow,
//         label: 'Start',
//         primary: true,
//         // onTap: cubit.startSession,
//         onTap: () {
//           HapticFeedback.mediumImpact();
//           cubit.startSession();
//         },
//       );
//     }
//     // ---------------------------
//     // START NEW SESSION -
//     // ---------------------------

//     if (state.phase == TractionPhase.stopped) {
//       return ControlButton(
//         icon: Icons.refresh,
//         label: 'Start New Session',
//         primary: true,
//         onTap: () {
//           HapticFeedback.mediumImpact();
//           cubit.startSession();
//         },
//       );
//     }
//     // ---------------------------
//     // COMPLETED - Start Again
//     // ---------------------------
//     if (state.phase == TractionPhase.completed) {
//       return ControlButton(
//         icon: Icons.replay,
//         label: 'Start Again',
//         primary: true,
//         onTap: () {
//           HapticFeedback.mediumImpact();
//           cubit.startSession();
//         },
//       );
//     }

//     // ---------------------------
//     // RUNNING - Pause / Stop
//     // ---------------------------
//     if (state.isRunning) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ControlButton(
//             icon: Icons.pause,
//             label: 'Pause',
//             // onTap: cubit.pauseSession,
//             onTap: () {
//               HapticFeedback.selectionClick();
//               cubit.pauseSession();
//             },
//           ),
//           const SizedBox(width: 16),
//           ControlButton(
//             icon: Icons.stop,
//             label: 'Stop',
//             // onTap: cubit.stopSession,
//             onTap: () {
//               HapticFeedback.selectionClick();
//               cubit.stopSession();
//             },
//           ),
//         ],
//       );
//     }

//     // ---------------------------
//     // PAUSED - Resume / Stop
//     // ---------------------------
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ControlButton(
//           icon: Icons.play_arrow,
//           label: 'Resume',
//           primary: true,
//           // onTap: cubit.resumeSession,
//           onTap: () {
//             HapticFeedback.selectionClick();
//             cubit.resumeSession();
//           },
//         ),
//         const SizedBox(width: 16),
//         ControlButton(
//           icon: Icons.stop,
//           label: 'Stop',
//           // onTap: cubit.stopSession,
//           onTap: () {
//             HapticFeedback.selectionClick();
//             cubit.stopSession();
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/traction_cubit.dart';
import '../../cubit/traction_state.dart';
import '../../../widgets/control_button.dart';

class ControlButtons extends StatelessWidget {
  final TractionState state;

  const ControlButtons({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TractionCubit>();

    // ---------------------------
    // IDLE - Start
    // ---------------------------
    if (state.phase == TractionPhase.idle) {
      return ControlButton(
        icon: Icons.play_arrow,
        label: 'Start',
        primary: true,
        // onTap: cubit.startSession,
        onTap: () {
          HapticFeedback.mediumImpact();
          cubit.startSession();
        },
      );
    }
    // ---------------------------
    // START NEW SESSION -
    // ---------------------------

    if (state.phase == TractionPhase.stopped) {
      return ControlButton(
        icon: Icons.refresh,
        label: 'Start New Session',
        primary: true,
        onTap: () {
          HapticFeedback.mediumImpact();
          cubit.startSession();
        },
      );
    }
    // ---------------------------
    // COMPLETED - Start Again
    // ---------------------------
    if (state.phase == TractionPhase.completed) {
      return ControlButton(
        icon: Icons.replay,
        label: 'Start Again',
        primary: true,
        onTap: () {
          HapticFeedback.mediumImpact();
          cubit.startSession();
        },
      );
    }

    // ---------------------------
    // RUNNING - Pause / Stop
    // ---------------------------
    if (state.isRunning) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ControlButton(
            icon: Icons.pause,
            label: 'Pause',
            // onTap: cubit.pauseSession,
            onTap: () {
              HapticFeedback.selectionClick();
              cubit.pauseSession();
            },
          ),
          const SizedBox(width: 16),
          ControlButton(
            icon: Icons.stop,
            label: 'Stop',

            backgroundColor: const Color(0xFF7A2E2E),
            foregroundColor: Colors.white,

            onTap: () {
              HapticFeedback.heavyImpact();
              cubit.stopSession();
            },
          ),
        ],
      );
    }

    // ---------------------------
    // PAUSED - Resume / Stop
    // ---------------------------
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ControlButton(
          icon: Icons.play_arrow,
          label: 'Resume',
          primary: true,
          // onTap: cubit.resumeSession,
          onTap: () {
            HapticFeedback.selectionClick();
            cubit.resumeSession();
          },
        ),
        const SizedBox(width: 16),
        ControlButton(
          icon: Icons.stop,
          label: 'Stop',

          backgroundColor: const Color(0xFF7A2E2E),
          foregroundColor: Colors.white,

          onTap: () {
            HapticFeedback.heavyImpact();
            cubit.stopSession();
          },
        ),
      ],
    );
  }
}
