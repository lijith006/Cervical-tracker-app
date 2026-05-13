import 'package:cervical_tracker/features/settings/view/widgets/wheel_picker_sheet.dart';
import 'package:flutter/material.dart';

class PickerHelper {
  static void showWheelPicker({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required int initialValue,
    required int minValue,
    required int maxValue,
    required String unit,
    required ValueChanged<int> onSelected,
  }) {
    int tempValue = initialValue;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,

      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return WheelPickerSheet(
              title: title,
              subtitle: subtitle,
              icon: icon,
              tempValue: tempValue,
              minValue: minValue,
              maxValue: maxValue,
              unit: unit,

              onValueChanged: (v) {
                setModalState(() {
                  tempValue = v;
                });
              },

              onDone: () {
                onSelected(tempValue);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
