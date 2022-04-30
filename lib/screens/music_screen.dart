import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/musics.dart';

class Player extends StatefulWidget {
  Musics music;
  Player(this.music, {Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    //Called on clicking play-pause button
    audioPlayer.onPlayerStateChanged.listen(
      (audioState) {
        setState(() {
          _isPlaying = audioState == PlayerState.PLAYING;
        });
      },
    );

    //Called when music changes
    audioPlayer.onDurationChanged.listen(
      (audioDuration) {
        setState(() {
          duration = audioDuration;
        });
      },
    );

    //Called on user's seek action
    audioPlayer.onAudioPositionChanged.listen(
      (audioPosition) {
        setState(() {
          position = audioPosition;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(214, 255, 255, 255),
      appBar: AppBar(
        title: Text(widget.music.title),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              //padding: const EdgeInsets.only(top: 30.0),
              height: 270,
              width: 270,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.music.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Divider(),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
              },
            ),
            IconButton(
              onPressed: () async {
                if (_isPlaying == true) {
                  await audioPlayer.pause();
                } else {
                  await audioPlayer.play(widget.music.url);
                }

                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
              icon: Icon((_isPlaying)
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill_sharp),
              iconSize: 70.0,
            ),
          ],
        ),
      ),
    );
  }
}
