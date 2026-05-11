import 'package:cervical_tracker/core/theme/app_colors.dart';
import 'package:cervical_tracker/features/traction/view/traction_screen.dart';
import 'package:cervical_tracker/features/widgets/control_button.dart';
import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/storage/hive_service.dart';
import 'package:cervical_tracker/features/traction/models/traction_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController totalController = TextEditingController();

  final TextEditingController tractionController = TextEditingController();

  final TextEditingController restController = TextEditingController();

  bool isLoading = true;

  // ---------------------------
  // LOAD SETTINGS
  // ---------------------------
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await HiveService.getSettings();

    totalController.text = (settings.totalSeconds ~/ 60).toString();

    tractionController.text = (settings.tractionSeconds ~/ 60).toString();

    restController.text = settings.restSeconds.toString();

    setState(() {
      isLoading = false;
    });
  }

  // ---------------------------
  // SAVE SETTINGS
  // ---------------------------
  Future<void> _saveSettings() async {
    final int totalMinutes = int.tryParse(totalController.text) ?? 30;

    final int tractionMinutes = int.tryParse(tractionController.text) ?? 5;

    final int restSeconds = int.tryParse(restController.text) ?? 10;

    // BASIC VALIDATION
    if (tractionMinutes <= 0 || totalMinutes <= 0 || restSeconds <= 0) {
      _showMessage('Values must be greater than zero');
      return;
    }

    final settings = TractionSettings(
      totalSeconds: totalMinutes * 60,
      tractionSeconds: tractionMinutes * 60,
      restSeconds: restSeconds,
    );

    await HiveService.saveSettings(settings);
    await HiveService.setSetupCompleted(true);

    if (!mounted) return;

    _showMessage('Settings Saved');
    //Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TractionScreen()),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    totalController.dispose();
    tractionController.dispose();
    restController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        title: const Text('Traction Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.tractionBackground),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [
                // TOTAL TIME
                TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: totalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Total Session (minutes)',
                    labelStyle: const TextStyle(color: AppColors.lightText),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // TRACTION TIME
                TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: tractionController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Traction Duration (minutes)',
                    labelStyle: const TextStyle(color: AppColors.lightText),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // REST TIME
                TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: restController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rest Duration (seconds)',
                    labelStyle: TextStyle(color: AppColors.lightText),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: ControlButton(
                        icon: Icons.save_rounded,
                        label: 'Save Settings',
                        primary: true,
                        onTap: _saveSettings,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
