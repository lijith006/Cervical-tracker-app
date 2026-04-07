import 'package:flutter/material.dart';
import '../../cubit/traction_state.dart';

class PhaseIndicator extends StatelessWidget {
  final TractionPhase phase;

  const PhaseIndicator({super.key, required this.phase});

  @override
  Widget build(BuildContext context) {
    final _PhaseStyle style = _resolveStyle(context, phase);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        style.label,
        style: TextStyle(
          color: style.textColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  _PhaseStyle _resolveStyle(BuildContext context, TractionPhase phase) {
    switch (phase) {
      case TractionPhase.idle:
        return _PhaseStyle(
          label: 'READY',
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.grey.shade800,
        );

      case TractionPhase.traction:
        return _PhaseStyle(
          label: 'TRACTION',
          backgroundColor: Colors.blue.shade100,
          textColor: Colors.blue.shade800,
        );

      case TractionPhase.rest:
        return _PhaseStyle(
          label: 'REST',
          backgroundColor: Colors.orange.shade100,
          textColor: Colors.orange.shade800,
        );

      case TractionPhase.completed:
        return _PhaseStyle(
          label: 'COMPLETED',
          backgroundColor: Colors.green.shade100,
          textColor: Colors.green.shade800,
        );
    }
  }
}

class _PhaseStyle {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const _PhaseStyle({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });
}
