import 'package:hive/hive.dart';
import '../../features/traction/models/traction_settings.dart';

class HiveService {
  static const _boxName = 'settings_box';
  static const _key = 'traction_settings';
  static const _setupKey = 'has_completed_setup';
  static Future<Box> _openBox() async {
    return await Hive.openBox(_boxName);
  }
  //GET SETTINGS

  static Future<TractionSettings> getSettings() async {
    final box = await _openBox();

    final data = box.get(_key);

    if (data == null) {
      final defaultSettings = TractionSettings.defaultSettings();
      await saveSettings(defaultSettings);
      return defaultSettings;
    }

    return TractionSettings.fromMap(Map<String, dynamic>.from(data));
  }

  //SAVE SETTINGS

  static Future<void> saveSettings(TractionSettings settings) async {
    final box = await _openBox();
    await box.put(_key, settings.toMap());
  }

  // ---------------------------
  // SETUP STATUS
  // ---------------------------

  static Future<bool> hasCompletedSetup() async {
    final box = await _openBox();
    return box.get(_setupKey, defaultValue: false);
  }

  static Future<void> setSetupCompleted(bool value) async {
    final box = await _openBox();
    await box.put(_setupKey, value);
  }
}
