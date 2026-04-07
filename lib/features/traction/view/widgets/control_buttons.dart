// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../cubit/traction_cubit.dart';
// import '../../cubit/traction_state.dart';

// class ControlButtons extends StatelessWidget {
//   final TractionState state;

//   const ControlButtons({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<TractionCubit>();

//     // ---------------------------
//     // IDLE → Start
//     // ---------------------------
//     if (state.phase == TractionPhase.idle) {
//       return ElevatedButton(
//         onPressed: cubit.startSession,
//         child: const Text('Start'),
//       );
//     }

//     // ---------------------------
//     // COMPLETED → Start Again
//     // ---------------------------
//     if (state.phase == TractionPhase.completed) {
//       return ElevatedButton(
//         onPressed: cubit.startSession,
//         child: const Text('Start Again'),
//       );
//     }

//     // ---------------------------
//     // RUNNING → Pause / Stop
//     // ---------------------------
//     if (state.isRunning) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: cubit.pauseSession,
//             child: const Text('Pause'),
//           ),
//           const SizedBox(width: 12),
//           OutlinedButton(
//             onPressed: cubit.stopSession,
//             child: const Text('Stop'),
//           ),
//         ],
//       );
//     }

//     // ---------------------------
//     // PAUSED → Resume / Stop
//     // ---------------------------
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: cubit.resumeSession,
//           child: const Text('Resume'),
//         ),
//         const SizedBox(width: 12),
//         OutlinedButton(onPressed: cubit.stopSession, child: const Text('Stop')),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
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
    // IDLE → Start
    // ---------------------------
    if (state.phase == TractionPhase.idle) {
      return ControlButton(
        icon: Icons.play_arrow,
        label: 'Start',
        primary: true,
        onTap: cubit.startSession,
      );
    }

    // ---------------------------
    // COMPLETED → Start Again
    // ---------------------------
    if (state.phase == TractionPhase.completed) {
      return ControlButton(
        icon: Icons.replay,
        label: 'Start Again',
        primary: true,
        onTap: cubit.startSession,
      );
    }

    // ---------------------------
    // RUNNING → Pause / Stop
    // ---------------------------
    if (state.isRunning) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ControlButton(
            icon: Icons.pause,
            label: 'Pause',
            onTap: cubit.pauseSession,
          ),
          const SizedBox(width: 16),
          ControlButton(
            icon: Icons.stop,
            label: 'Stop',
            onTap: cubit.stopSession,
          ),
        ],
      );
    }

    // ---------------------------
    // PAUSED → Resume / Stop
    // ---------------------------
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ControlButton(
          icon: Icons.play_arrow,
          label: 'Resume',
          primary: true,
          onTap: cubit.resumeSession,
        ),
        const SizedBox(width: 16),
        ControlButton(
          icon: Icons.stop,
          label: 'Stop',
          onTap: cubit.stopSession,
        ),
      ],
    );
  }
}
