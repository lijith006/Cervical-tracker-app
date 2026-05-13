// import 'package:cervical_tracker/core/animations/page_transition.dart';
// import 'package:cervical_tracker/core/theme/app_colors.dart';
// import 'package:cervical_tracker/features/settings/validators/settings_validator.dart';
// import 'package:cervical_tracker/features/traction/view/traction_screen.dart';
// import 'package:cervical_tracker/features/widgets/control_button.dart';
// import 'package:flutter/material.dart';
// import 'package:cervical_tracker/core/storage/hive_service.dart';
// import 'package:cervical_tracker/features/traction/models/traction_settings.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   final TextEditingController totalController = TextEditingController();

//   final TextEditingController tractionController = TextEditingController();

//   final TextEditingController restController = TextEditingController();

//   bool isLoading = true;

//   // ---------------------------
//   // LOAD SETTINGS
//   // ---------------------------
//   @override
//   void initState() {
//     super.initState();
//     _loadSettings();
//   }

//   Future<void> _loadSettings() async {
//     final settings = await HiveService.getSettings();

//     totalController.text = (settings.totalSeconds ~/ 60).toString();

//     tractionController.text = (settings.tractionSeconds ~/ 60).toString();

//     restController.text = settings.restSeconds.toString();

//     setState(() {
//       isLoading = false;
//     });
//   }

//   // ---------------------------
//   // SAVE SETTINGS
//   // ---------------------------
//   Future<void> _saveSettings() async {
//     final int? totalMinutes = int.tryParse(totalController.text);

//     final int? tractionMinutes = int.tryParse(tractionController.text);

//     final int? restSeconds = int.tryParse(restController.text);

//     // VALIDATION
//     final error = SettingsValidator.validate(
//       totalMinutes: totalMinutes,
//       tractionMinutes: tractionMinutes,
//       restSeconds: restSeconds,
//     );

//     if (error != null) {
//       _showMessage(error);
//       return;
//     }

//     final settings = TractionSettings(
//       totalSeconds: totalMinutes! * 60,
//       tractionSeconds: tractionMinutes! * 60,
//       restSeconds: restSeconds!,
//     );

//     await HiveService.saveSettings(settings);

//     await HiveService.setSetupCompleted(true);

//     if (!mounted) return;

//     _showMessage('Settings Saved');

//     Navigator.pushReplacement(
//       context,
//       AppPageTransition(page: const TractionScreen()),
//     );
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   void dispose() {
//     totalController.dispose();
//     tractionController.dispose();
//     restController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: AppColors.darkBlue1,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//       ),

//       body: Container(
//         decoration: const BoxDecoration(gradient: AppColors.tractionBackground),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),

//             child: Column(
//               children: [
//                 // TOTAL TIME
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white,
//                   controller: totalController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Total Session (minutes)',
//                     labelStyle: const TextStyle(color: AppColors.lightText),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(color: Colors.white24),
//                     ),

//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(
//                         color: Colors.white,
//                         width: 1.5,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // TRACTION TIME
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white,
//                   controller: tractionController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Traction Duration (minutes)',
//                     labelStyle: const TextStyle(color: AppColors.lightText),

//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(color: Colors.white24),
//                     ),

//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(
//                         color: Colors.white,
//                         width: 1.5,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // REST TIME
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white,
//                   controller: restController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Rest Duration (seconds)',
//                     labelStyle: TextStyle(color: AppColors.lightText),

//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(color: Colors.white24),
//                     ),

//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(
//                         color: Colors.white,
//                         width: 1.5,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: Center(
//                       child: ControlButton(
//                         icon: Icons.save_rounded,
//                         label: 'Save Settings',
//                         primary: true,
//                         onTap: _saveSettings,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//updated with time picker

// import 'package:cervical_tracker/core/animations/page_transition.dart';
// import 'package:cervical_tracker/core/theme/app_colors.dart';
// import 'package:cervical_tracker/features/settings/validators/settings_validator.dart';
// import 'package:cervical_tracker/features/traction/view/traction_screen.dart';
// import 'package:cervical_tracker/features/widgets/control_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cervical_tracker/core/storage/hive_service.dart';
// import 'package:cervical_tracker/features/traction/models/traction_settings.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen>
//     with TickerProviderStateMixin {
//   int totalMinutes = 20;
//   int tractionMinutes = 5;
//   int restSeconds = 30;

//   bool isLoading = true;

//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;

//   // ---------------------------
//   // INIT
//   // ---------------------------
//   @override
//   void initState() {
//     super.initState();
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeOut,
//     );
//     _loadSettings();
//   }

//   Future<void> _loadSettings() async {
//     final settings = await HiveService.getSettings();
//     setState(() {
//       totalMinutes = settings.totalSeconds ~/ 60;
//       tractionMinutes = settings.tractionSeconds ~/ 60;
//       restSeconds = settings.restSeconds;
//       isLoading = false;
//     });
//     _fadeController.forward();
//   }

//   // ---------------------------
//   // SAVE SETTINGS
//   // ---------------------------
//   Future<void> _saveSettings() async {
//     final error = SettingsValidator.validate(
//       totalMinutes: totalMinutes,
//       tractionMinutes: tractionMinutes,
//       restSeconds: restSeconds,
//     );

//     if (error != null) {
//       _showMessage(error);
//       return;
//     }

//     final settings = TractionSettings(
//       totalSeconds: totalMinutes * 60,
//       tractionSeconds: tractionMinutes * 60,
//       restSeconds: restSeconds,
//     );

//     await HiveService.saveSettings(settings);
//     await HiveService.setSetupCompleted(true);

//     if (!mounted) return;
//     //_showMessage('Settings Saved');

//     Navigator.pushReplacement(
//       context,
//       AppPageTransition(page: const TractionScreen()),
//     );
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.white12,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }

//   // ---------------------------
//   // WHEEL PICKER BOTTOM SHEET
//   // ---------------------------
//   void _showWheelPicker({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required int initialValue,
//     required int minValue,
//     required int maxValue,
//     required String unit,
//     required ValueChanged<int> onSelected,
//   }) {
//     int tempValue = initialValue;

//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (_) {
//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return Container(
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xFF1A2744), Color(0xFF0D1B3E)],
//                 ),
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(32),
//                 ),
//                 border: Border.all(color: Colors.white10, width: 1),
//               ),
//               padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Drag handle
//                   Container(
//                     width: 40,
//                     height: 4,
//                     margin: const EdgeInsets.only(bottom: 24),
//                     decoration: BoxDecoration(
//                       color: Colors.white24,
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),

//                   // Title row
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.white10,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(icon, color: Colors.white70, size: 20),
//                       ),
//                       const SizedBox(width: 14),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             title,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.3,
//                             ),
//                           ),
//                           Text(
//                             subtitle,
//                             style: const TextStyle(
//                               color: Colors.white38,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       TextButton(
//                         onPressed: () {
//                           onSelected(tempValue);
//                           Navigator.pop(context);
//                         },
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 10,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         child: const Text(
//                           'Done',
//                           style: TextStyle(
//                             color: Color(0xFF0D1B3E),
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   // Current value display
//                   TweenAnimationBuilder<double>(
//                     tween: Tween(begin: 0.9, end: 1.0),
//                     duration: const Duration(milliseconds: 200),
//                     builder: (context, scale, child) =>
//                         Transform.scale(scale: scale, child: child),
//                     child: Text(
//                       '$tempValue',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 64,
//                         fontWeight: FontWeight.w200,
//                         letterSpacing: -2,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     unit,
//                     style: const TextStyle(
//                       color: Colors.white38,
//                       fontSize: 14,
//                       letterSpacing: 2,
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // Wheel picker
//                   SizedBox(
//                     height: 180,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // Selection highlight
//                         Container(
//                           height: 52,
//                           margin: const EdgeInsets.symmetric(horizontal: 40),
//                           decoration: BoxDecoration(
//                             color: Colors.white10,
//                             borderRadius: BorderRadius.circular(14),
//                             border: Border.all(color: Colors.white12),
//                           ),
//                         ),
//                         CupertinoPicker(
//                           scrollController: FixedExtentScrollController(
//                             initialItem: tempValue - minValue,
//                           ),
//                           itemExtent: 52,
//                           diameterRatio: 1.4,
//                           squeeze: 1.0,
//                           selectionOverlay: const SizedBox.shrink(),
//                           onSelectedItemChanged: (i) {
//                             setModalState(() => tempValue = i + minValue);
//                           },
//                           children: List.generate(
//                             maxValue - minValue + 1,
//                             (i) => Center(
//                               child: Text(
//                                 '${i + minValue}',
//                                 style: TextStyle(
//                                   color: (i + minValue) == tempValue
//                                       ? Colors.white
//                                       : Colors.white38,
//                                   fontSize: 22,
//                                   fontWeight: (i + minValue) == tempValue
//                                       ? FontWeight.w500
//                                       : FontWeight.w300,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // ---------------------------
//   // BUILD
//   // ---------------------------
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(
//         backgroundColor: AppColors.darkBlue1,
//         body: Center(child: CircularProgressIndicator(color: Colors.white38)),
//       );
//     }

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: AppColors.darkBlue1,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(gradient: AppColors.tractionBackground),
//         child: SafeArea(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Session\nSettings',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 38,
//                       fontWeight: FontWeight.w200,
//                       height: 1.15,
//                       letterSpacing: -1,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     'Configure your traction session timings',
//                     style: TextStyle(
//                       color: Colors.white38,
//                       fontSize: 14,
//                       letterSpacing: 0.2,
//                     ),
//                   ),
//                   const SizedBox(height: 36),

//                   // Cards
//                   _WheelPickerCard(
//                     // index: '01',
//                     label: 'Total Session',
//                     unit: 'minutes',
//                     value: totalMinutes,
//                     icon: Icons.timer_outlined,
//                     accentColor: const Color(0xFF4A90D9),
//                     onTap: () => _showWheelPicker(
//                       title: 'Total Session',
//                       subtitle: 'Full session duration',
//                       icon: Icons.timer_outlined,
//                       initialValue: totalMinutes,
//                       minValue: 1,
//                       maxValue: 120,
//                       unit: 'minutes',
//                       onSelected: (v) => setState(() => totalMinutes = v),
//                     ),
//                   ),

//                   const SizedBox(height: 14),

//                   _WheelPickerCard(
//                     // index: '02',
//                     label: 'Traction Duration',
//                     unit: 'minutes',
//                     value: tractionMinutes,
//                     icon: Icons.compress_outlined,
//                     accentColor: const Color(0xFF5BA8A0),
//                     onTap: () => _showWheelPicker(
//                       title: 'Traction Duration',
//                       subtitle: 'Active traction phase',
//                       icon: Icons.compress_outlined,
//                       initialValue: tractionMinutes,
//                       minValue: 1,
//                       maxValue: 60,
//                       unit: 'minutes',
//                       onSelected: (v) => setState(() => tractionMinutes = v),
//                     ),
//                   ),

//                   const SizedBox(height: 14),

//                   // Rest — Stepper card
//                   _StepperCard(
//                     // index: '03',
//                     label: 'Rest Duration',
//                     unit: 'seconds',
//                     value: restSeconds,
//                     icon: Icons.self_improvement_outlined,
//                     accentColor: const Color(0xFF8B7ED8),
//                     min: 5,
//                     max: 120,
//                     step: 5,
//                     onChanged: (v) => setState(() => restSeconds = v),
//                   ),

//                   const Spacer(),

//                   // Save button
//                   SizedBox(
//                     width: double.infinity,
//                     child: Center(
//                       child: ControlButton(
//                         icon: Icons.save_rounded,
//                         label: 'Save Settings',
//                         primary: true,
//                         onTap: _saveSettings,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     super.dispose();
//   }
// }

// // ---------------------------
// // WHEEL PICKER CARD WIDGET
// // ---------------------------
// class _WheelPickerCard extends StatelessWidget {
//   final String label;
//   final String unit;
//   final int value;
//   final IconData icon;
//   final Color accentColor;
//   final VoidCallback onTap;

//   const _WheelPickerCard({
//     required this.label,
//     required this.unit,
//     required this.value,
//     required this.icon,
//     required this.accentColor,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.white.withOpacity(0.08)),
//         ),
//         child: Row(
//           children: [
//             // Index + icon
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 8),
//                 Container(
//                   padding: const EdgeInsets.all(9),
//                   decoration: BoxDecoration(
//                     color: accentColor.withOpacity(0.12),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(icon, color: accentColor, size: 20),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 16),

//             // Label + subtitle
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     label,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 0.2,
//                     ),
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     'Tap to change',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.3),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Value display
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   '$value',
//                   style: TextStyle(
//                     color: accentColor,
//                     fontSize: 32,
//                     fontWeight: FontWeight.w300,
//                     letterSpacing: -1,
//                   ),
//                 ),
//                 Text(
//                   unit,
//                   style: TextStyle(
//                     color: accentColor.withOpacity(0.5),
//                     fontSize: 11,
//                     letterSpacing: 0.8,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(width: 8),
//             Icon(
//               Icons.chevron_right_rounded,
//               color: Colors.white.withOpacity(0.2),
//               size: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ---------------------------
// // STEPPER CARD WIDGET
// // ---------------------------
// class _StepperCard extends StatelessWidget {
//   //final String index;
//   final String label;
//   final String unit;
//   final int value;
//   final IconData icon;
//   final Color accentColor;
//   final int min;
//   final int max;
//   final int step;
//   final ValueChanged<int> onChanged;

//   const _StepperCard({
//     // required this.index,
//     required this.label,
//     required this.unit,
//     required this.value,
//     required this.icon,
//     required this.accentColor,
//     required this.min,
//     required this.max,
//     required this.step,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final canDecrement = value > min;
//     final canIncrement = value < max;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white.withOpacity(0.08)),
//       ),
//       child: Row(
//         children: [
//           // Index + icon
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 8),
//               Container(
//                 padding: const EdgeInsets.all(9),
//                 decoration: BoxDecoration(
//                   color: accentColor.withOpacity(0.12),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, color: accentColor, size: 20),
//               ),
//             ],
//           ),
//           const SizedBox(width: 16),

//           // Label
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 0.2,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   '$min–$max $unit',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.3),
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Stepper controls
//           Row(
//             children: [
//               _StepButton(
//                 icon: Icons.remove_rounded,
//                 enabled: canDecrement,
//                 accentColor: accentColor,
//                 onTap: canDecrement ? () => onChanged(value - step) : null,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Column(
//                   children: [
//                     Text(
//                       '$value',
//                       style: TextStyle(
//                         color: accentColor,
//                         fontSize: 28,
//                         fontWeight: FontWeight.w300,
//                         letterSpacing: -0.5,
//                       ),
//                     ),
//                     Text(
//                       unit,
//                       style: TextStyle(
//                         color: accentColor.withOpacity(0.5),
//                         fontSize: 11,
//                         letterSpacing: 0.8,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               _StepButton(
//                 icon: Icons.add_rounded,
//                 enabled: canIncrement,
//                 accentColor: accentColor,
//                 onTap: canIncrement ? () => onChanged(value + step) : null,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StepButton extends StatelessWidget {
//   final IconData icon;
//   final bool enabled;
//   final Color accentColor;
//   final VoidCallback? onTap;

//   const _StepButton({
//     required this.icon,
//     required this.enabled,
//     required this.accentColor,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         width: 36,
//         height: 36,
//         decoration: BoxDecoration(
//           color: enabled
//               ? accentColor.withOpacity(0.15)
//               : Colors.white.withOpacity(0.04),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: enabled
//                 ? accentColor.withOpacity(0.3)
//                 : Colors.white.withOpacity(0.06),
//           ),
//         ),
//         child: Icon(
//           icon,
//           size: 18,
//           color: enabled ? accentColor : Colors.white24,
//         ),
//       ),
//     );
//   }
// }

//  Refactoring

import 'package:cervical_tracker/core/animations/page_transition.dart';
import 'package:cervical_tracker/core/storage/hive_service.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';

import 'package:cervical_tracker/features/settings/validators/settings_validator.dart';
import 'package:cervical_tracker/features/settings/view/constants/settings_limit.dart';
import 'package:cervical_tracker/features/settings/view/helpers/picker_helper.dart';
import 'package:cervical_tracker/features/settings/view/widgets/loading_scaffold.dart';
import 'package:cervical_tracker/features/settings/view/widgets/settings_header.dart';
import 'package:cervical_tracker/features/settings/view/widgets/stepper_card.dart';
import 'package:cervical_tracker/features/settings/view/widgets/wheel_picker_card.dart';

import 'package:cervical_tracker/features/traction/models/traction_settings.dart';
import 'package:cervical_tracker/features/traction/view/traction_screen.dart';
import 'package:cervical_tracker/features/widgets/control_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  int totalMinutes = 20;
  int tractionMinutes = 5;
  int restSeconds = 30;

  bool isLoading = true;

  late final AnimationController fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  late final Animation<double> fadeAnimation = CurvedAnimation(
    parent: fadeController,
    curve: Curves.easeOut,
  );

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  @override
  void dispose() {
    fadeController.dispose();
    super.dispose();
  }

  Future<void> loadSettings() async {
    final settings = await HiveService.getSettings();

    if (!mounted) return;

    setState(() {
      totalMinutes = settings.totalSeconds ~/ 60;
      tractionMinutes = settings.tractionSeconds ~/ 60;
      restSeconds = settings.restSeconds;
      isLoading = false;
    });

    fadeController.forward();
  }

  Future<void> saveSettings() async {
    final error = SettingsValidator.validate(
      totalMinutes: totalMinutes,
      tractionMinutes: tractionMinutes,
      restSeconds: restSeconds,
    );

    if (error != null) {
      HapticFeedback.mediumImpact();

      showError(error);
      return;
    }

    await HiveService.saveSettings(
      TractionSettings(
        totalSeconds: totalMinutes * 60,
        tractionSeconds: tractionMinutes * 60,
        restSeconds: restSeconds,
      ),
    );

    await HiveService.setSetupCompleted(true);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      AppPageTransition(page: const TractionScreen()),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingScaffold();
    }

    return Scaffold(
      backgroundColor: AppColors.darkBlue1,

      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.tractionBackground),

        child: SafeArea(
          child: FadeTransition(
            opacity: fadeAnimation,

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SettingsHeader(),

                  const SizedBox(height: 30),

                  WheelPickerCard(
                    label: 'Total Session',
                    unit: 'minutes',
                    value: totalMinutes,
                    icon: Icons.timer_outlined,
                    accentColor: const Color(0xFF4A90D9),

                    onTap: () {
                      HapticFeedback.lightImpact();

                      PickerHelper.showWheelPicker(
                        context: context,
                        title: 'Total Session',
                        subtitle: 'Full session duration',
                        icon: Icons.timer_outlined,
                        initialValue: totalMinutes,
                        minValue: SettingsLimits.minTotalMinutes,
                        maxValue: SettingsLimits.maxTotalMinutes,
                        unit: 'minutes',

                        onSelected: (v) {
                          setState(() {
                            totalMinutes = v;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  WheelPickerCard(
                    label: 'Traction Duration',
                    unit: 'minutes',
                    value: tractionMinutes,
                    icon: Icons.compress_outlined,
                    accentColor: const Color(0xFF5BA8A0),

                    onTap: () {
                      PickerHelper.showWheelPicker(
                        context: context,
                        title: 'Traction Duration',
                        subtitle: 'Active traction phase',
                        icon: Icons.compress_outlined,
                        initialValue: tractionMinutes,
                        minValue: SettingsLimits.minTractionMinutes,
                        // maxValue: SettingsLimits.maxTractionMinutes,
                        maxValue: totalMinutes,
                        unit: 'minutes',

                        onSelected: (v) {
                          setState(() {
                            tractionMinutes = v;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  StepperCard(
                    label: 'Rest Duration',
                    unit: 'seconds',
                    value: restSeconds,
                    icon: Icons.self_improvement_outlined,
                    accentColor: const Color(0xFF8B7ED8),
                    min: SettingsLimits.minRestSeconds,
                    max: SettingsLimits.maxRestSeconds,
                    step: SettingsLimits.restStep,

                    onChanged: (v) {
                      setState(() {
                        restSeconds = v;
                      });
                    },
                  ),
                  // SizedBox(height: 30),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      //  width: double.infinity,
                      child: ControlButton(
                        icon: Icons.save_rounded,
                        label: 'Save',
                        primary: true,
                        // onTap: saveSettings,
                        onTap: () async {
                          HapticFeedback.mediumImpact();
                          await saveSettings();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
