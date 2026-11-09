import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

abstract interface class CryPlayer {
  Future<void> play(File file);

  Future<void> dispose();
}

class AudioplayersCryPlayer implements CryPlayer {
  AudioplayersCryPlayer() : _player = AudioPlayer();

  final AudioPlayer _player;

  @override
  Future<void> play(File file) async {
    try {
      await _player.stop();
      await _player.play(DeviceFileSource(file.path));
    } on Object {
      // Sin códec .ogg (iOS) o sin salida de audio: silencio, no error.
    }
  }

  @override
  Future<void> dispose() async {
    try {
      await _player.dispose();
    } on Object {
      // Ya estaba liberado.
    }
  }
}
