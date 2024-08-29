import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer player;
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('file_example_MP3_700KB.mp3'));
      // await player.resume();
    });

    _initStreams();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(title: Text('Audio Player')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: _playerState == PlayerState.playing ? null : _play,
                iconSize: 48.0,
                icon: Icon(Icons.play_arrow),
                color: color,
              ),
              IconButton(
                onPressed: _playerState == PlayerState.playing ? _pause : null,
                iconSize: 48.0,
                icon: Icon(Icons.pause),
                color: color,
              ),
              IconButton(
                onPressed: _playerState == PlayerState.playing || _playerState == PlayerState.paused ? _stop : null,
                iconSize: 48.0,
                icon: Icon(Icons.stop),
                color: color,
              ),
            ],
          ),
          Slider(
            onChanged: (value) {
              final duration = _duration;
              if (duration == null) return;
              final position = value * duration.inMilliseconds;
              player.seek(Duration(milliseconds: position.round()));
            },
            value: (_position != null &&
                _duration != null &&
                _position!.inMilliseconds > 0 &&
                _position!.inMilliseconds < _duration!.inMilliseconds)
                ? _position!.inMilliseconds / _duration!.inMilliseconds
                : 0.0,
          ),
          Text(
            _position != null
                ? '${_position.toString().split('.').first} / ${_duration.toString().split('.').first}'
                : _duration != null
                ? _duration.toString().split('.').first
                : '',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen((position) {
      setState(() => _position = position);
    });

    _playerCompleteSubscription = player.onPlayerComplete.listen((_) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription = player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }
}
