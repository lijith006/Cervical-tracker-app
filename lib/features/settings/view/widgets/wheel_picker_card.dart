import 'package:flutter/material.dart';

class WheelPickerCard extends StatelessWidget {
  final String label;
  final String unit;
  final int value;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const WheelPickerCard({
    super.key,
    required this.label,
    required this.unit,
    required this.value,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
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
                    'Tap to change',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$value',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 32,
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

            const SizedBox(width: 8),

            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
