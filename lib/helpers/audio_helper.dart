import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioHelperProvider =
    Provider<AudioHelper>((ref) => AudioHelper.create());

class AudioHelper {
  final AudioPlayer _audioPlayer;

  AudioHelper._(this._audioPlayer);

  factory AudioHelper.create() {
    return AudioHelper._(AudioPlayer());
  }

  void stop() {
    try {
      _audioPlayer.stop();
    } catch (_) {}
  }

  void playBleepSound() {
    _playAssetSound('sounds/sfx_task_done_bleep.mp3');
  }

  void playSuccessSound() {
    _playAssetSound('sounds/sfx_step_completed_success.mp3');
  }

  void playVictorySound() {
    _playAssetSound('sounds/sfx_you_win.mp3');
  }

  void playWooshSound() {
    _playAssetSound('sounds/sfx_undo_woosh.mp3');
  }

  void _playAssetSound(String path) {
    _audioPlayer.play(AssetSource(path));
  }
}
