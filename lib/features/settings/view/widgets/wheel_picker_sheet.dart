import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WheelPickerSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final int tempValue;
  final int minValue;
  final int maxValue;
  final String unit;
  final ValueChanged<int> onValueChanged;
  final VoidCallback onDone;

  const WheelPickerSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tempValue,
    required this.minValue,
    required this.maxValue,
    required this.unit,
    required this.onValueChanged,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A2744), Color(0xFF0D1B3E)],
        ),

        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Icon(icon, color: Colors.white70),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  Text(subtitle, style: const TextStyle(color: Colors.white38)),
                ],
              ),

              const Spacer(),

              TextButton(onPressed: onDone, child: const Text('Done')),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            '$tempValue',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.w200,
            ),
          ),

          Text(unit, style: const TextStyle(color: Colors.white38)),

          const SizedBox(height: 20),

          SizedBox(
            height: 180,

            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: tempValue - minValue,
              ),

              itemExtent: 52,

              onSelectedItemChanged: (i) {
                HapticFeedback.selectionClick();

                onValueChanged(i + minValue);
              },

              children: List.generate(maxValue - minValue + 1, (i) {
                final value = i + minValue;

                return Center(
                  child: Text(
                    '$value',
                    style: TextStyle(
                      color: value == tempValue ? Colors.white : Colors.white38,
                      fontSize: 22,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
