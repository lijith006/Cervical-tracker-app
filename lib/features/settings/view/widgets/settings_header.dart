import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Session\nSettings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 38,
            fontWeight: FontWeight.w200,
            height: 1.15,
            letterSpacing: -1,
          ),
        ),

        SizedBox(height: 6),

        Text(
          'Configure your traction session timings',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 14,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
