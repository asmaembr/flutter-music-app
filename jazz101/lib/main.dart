import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';


Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'come.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Music App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const AudioPlayerScreen(),
    );
  }
}

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});
  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;


  final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(
    children: [
        AudioSource.uri(
        Uri.parse('asset:///assets/audio/Incredible.mp3'),
        tag: MediaItem(
          id: '0',
          title: 'Incredible',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/5.jpg'),
        ),
      ),
     
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/Big_Easy.mp3'),
        tag: MediaItem(
          id: '1',
          title: 'Big Easy',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/1.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/Blue_Monk.mp3'),
        tag: MediaItem(
          id: '2',
          title: 'Blue Monk',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/2.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/Coldness.mp3'),
        tag: MediaItem(
          id: '3',
          title: 'Coldness',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/3.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/If_I_Wait.mp3'),
        tag: MediaItem(
          id: '4',
          title: 'If I Wait',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/4.jpg'),
        ),
      ),
  AudioSource.uri(
        Uri.parse('asset:///assets/audio/Arana.mp3'),
        tag: MediaItem(
          id: '5',
          title: 'Arana',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/0.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/Mladost_Club.mp3'),
        tag: MediaItem(
          id: '6',
          title: 'Mladost Club',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/6.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/Mount_Fuji.mp3'),
        tag: MediaItem(
          id: '7',
          title: 'Mount Fuji',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/7.jpg'),
        ),
      ),

      AudioSource.uri(
        Uri.parse('asset:///assets/audio/something.mp3'),
        tag: MediaItem(
          id: '9',
          title: 'Something',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/9.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/The_Harold_Rubin.mp3'),
        tag: MediaItem(
          id: '10',
          title: 'The father The son and The Harold Rubin',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/10.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/The_Years.mp3'),
        tag: MediaItem(
          id: '11',
          title: 'The Years',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/11.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/John-Bartmann-A-Kwela-Fella.mp3'),
        tag: MediaItem(
          id: '12',
          title: 'A Kwela Fella',
          artist: 'John Bartmann',
          artUri: Uri.parse('assets/arts/12.jpg'),
        ),
      ),

      AudioSource.uri(
        Uri.parse('asset:///assets/audio/cooking.mp3'),
        tag: MediaItem(
          id: '14',
          title: 'Cooking',
          artist: 'Public Domain',
          artUri: Uri.parse('assets/arts/14.jpg'),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/Osamu-Fukuzawa-Bossa-nova.mp3'),
        tag: MediaItem(
          id: '15',
          title: 'Bossa nova',
          artist: 'Osamu Fukuzawa',
          artUri: Uri.parse('assets/arts/15.jpg'),
        ),
      ),
    ],
  );

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferePosition, duration) => PositionData(
          position,
          bufferePosition,
          duration ?? Duration.zero,
        ),
      );
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playlist);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white,Colors.amber],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return const SizedBox();
                }
                final metadata = state!.currentSource!.tag as MediaItem;
                return MediaMetadata(
                  assetPath: metadata.artUri.toString(),
                  artist: metadata.artist ?? '',
                  title: metadata.title,
                );
              },
            ),
            const SizedBox(height: 20),
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return ProgressBar(
                  barHeight: 8,
                  baseBarColor:  Colors.grey[500],
                  bufferedBarColor: Colors.grey[600],
                  progressBarColor: Colors.black,
                  thumbColor: Colors.black,
                  timeLabelTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  onSeek: _audioPlayer.seek,
                );
              },
            ),
            const SizedBox(height: 20),
            Controls(
              audioPlayer: _audioPlayer
            ),
          ],
        ),
      ),
    );
  }
}

class MediaMetadata extends StatelessWidget {
  const MediaMetadata({
    super.key,
    required this.assetPath,
    required this.title,
    required this.artist,
  });
  final String assetPath;
  final String title;
  final String artist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 4),
                blurRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              assetPath,
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          artist,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: audioPlayer.seekToPrevious,
          iconSize: 60,
          color: Colors.black,
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (!(playing ?? false)) {
              return IconButton(
                onPressed: audioPlayer.play,
                iconSize: 80,
                color: Colors.black,
                icon: const Icon(Icons.play_arrow_rounded),
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                onPressed: audioPlayer.pause,
                iconSize: 80,
                color: Colors.black,
                icon: const Icon(Icons.pause_rounded),
              );
            }
            return const Icon(
              Icons.play_arrow_rounded,
              color: Colors.black,
              size: 80,
            );
          },
        ),
        IconButton(
          onPressed: audioPlayer.seekToNext,
          iconSize: 60,
          color: Colors.black,
          icon: const Icon(Icons.skip_next_rounded),
        ),
       
      ],
    );
  }
}
