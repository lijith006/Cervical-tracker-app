import 'package:cervical_tracker/features/settings/view/widgets/step_button.dart';
import 'package:flutter/material.dart';

class StepperCard extends StatelessWidget {
  final String label;
  final String unit;
  final int value;
  final IconData icon;
  final Color accentColor;
  final int min;
  final int max;
  final int step;
  final ValueChanged<int> onChanged;

  const StepperCard({
    super.key,
    required this.label,
    required this.unit,
    required this.value,
    required this.icon,
    required this.accentColor,
    required this.min,
    required this.max,
    required this.step,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),

            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icon, color: accentColor, size: 20),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '$min–$max $unit',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              StepButton(
                icon: Icons.remove_rounded,
                enabled: value > min,
                accentColor: accentColor,
                onTap: value > min ? () => onChanged(value - step) : null,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),

                child: Column(
                  children: [
                    Text(
                      '$value',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),

                    Text(
                      unit,
                      style: TextStyle(
                        color: accentColor.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              StepButton(
                icon: Icons.add_rounded,
                enabled: value < max,
                accentColor: accentColor,
                onTap: value < max ? () => onChanged(value + step) : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
