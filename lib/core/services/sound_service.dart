import 'package:audioplayers/audioplayers.dart';

class SoundService {
  // static AudioPlayer? _tickPlayer;

  static AudioPlayer _createPlayer() {
    return AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  }

  static Future<void> _play(String assetPath) async {
    final player = _createPlayer();
    await player.play(AssetSource(assetPath));
  }

  // ---------------------------
  // Session lifecycle sounds
  // ---------------------------

  static Future<void> playSessionStart() async {
    await _play('sounds/start.mp3');
  }

  static Future<void> playRestStart() async {
    await _play('sounds/rest.mp3');
  }

  static Future<void> playTractionResume() async {
    await _play('sounds/start.mp3');
  }

  static Future<void> playPause() async {
    await _play('sounds/click.mp3');
  }

  static Future<void> playResume() async {
    await _play('sounds/click.mp3');
  }

  static Future<void> playSessionCompleted() async {
    await _play('sounds/completed_sound.mp3');
  }

  // // ---------------------------
  // // Ticking sound (looping)
  // // ---------------------------
  // static Future<void> startTicking() async {
  //   _tickPlayer ??= AudioPlayer();
  //   await _tickPlayer!.setReleaseMode(ReleaseMode.loop);
  //   await _tickPlayer!.play(AssetSource('sounds/ticking_sound.mp3'));
  // }

  // static Future<void> stopTicking() async {
  //   if (_tickPlayer != null) {
  //     await _tickPlayer!.stop();
  //   }
  // }
}
