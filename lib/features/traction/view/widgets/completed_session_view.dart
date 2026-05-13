import 'package:cervical_tracker/features/traction/cubit/traction_cubit.dart';
import 'package:cervical_tracker/features/traction/cubit/traction_state.dart';
import 'package:cervical_tracker/features/widgets/control_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedSessionView extends StatefulWidget {
  final TractionState state;

  const CompletedSessionView({super.key, required this.state});

  @override
  State<CompletedSessionView> createState() => _CompletedSessionViewState();
}

class _CompletedSessionViewState extends State<CompletedSessionView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;

  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get completedMinutes {
    return widget.state.initialTotalSeconds ~/ 60;
  }

  int get completedCycles {
    return completedMinutes ~/ 5;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TractionCubit>();

    return FadeTransition(
      opacity: _fadeAnimation,

      child: ScaleTransition(
        scale: _scaleAnimation,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CHECK ICON
              Container(
                width: 110,
                height: 110,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF5BC9A8).withOpacity(0.12),

                  border: Border.all(
                    color: const Color(0xFF5BC9A8).withOpacity(0.3),
                    width: 1.5,
                  ),
                ),

                child: const Icon(
                  Icons.check_rounded,
                  size: 58,
                  color: Color(0xFF5BC9A8),
                ),
              ),

              const SizedBox(height: 30),

              // TITLE
              const Text(
                'Session Completed',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'You completed your traction session successfully.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 42),

              // STATS CARD
              Container(
                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 22,
                ),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),

                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),

                child: Column(
                  children: [
                    _StatTile(
                      label: 'Total Time',
                      value: '$completedMinutes min',
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Divider(color: Colors.white12, height: 1),
                    ),

                    // _StatTile(
                    //   label: 'Cycles Completed',
                    //   value: '$completedCycles',
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // START AGAIN BUTTON
              ControlButton(
                icon: Icons.replay,
                label: 'Start Again',
                primary: true,
                onTap: cubit.startSession,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;

  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,

          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15),
        ),

        const Spacer(),

        Text(
          value,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
