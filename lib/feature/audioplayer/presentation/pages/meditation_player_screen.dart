import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import "package:navithera_client/l10n/app_localizations.dart";
import 'package:navithera_client/core/theme/app_colors.dart';
import 'meditation_list_screen.dart';

class MeditationPlayerScreen extends StatefulWidget {
  final MeditationItem meditation;

  const MeditationPlayerScreen({Key? key, required this.meditation})
    : super(key: key);

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  late final AudioPlayer audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    audioPlayer.onDurationChanged.listen((d) {
      if (!mounted) return;
      setState(() => duration = d);
    });

    audioPlayer.onPositionChanged.listen((p) {
      if (!mounted) return;
      setState(() => position = p);
    });

    audioPlayer.onPlayerComplete.listen((event) {
      if (!mounted) return;
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playPause() async {
    if (isPlaying) {
      try {
        await audioPlayer.pause();
        if (!mounted) return;
        setState(() => isPlaying = false);
      } catch (e) {
        debugPrint('Pause error: $e');
      }
    } else {
      try {
        // meditation.audioPath must be listed in pubspec.yaml under assets.
        await audioPlayer.play(AssetSource(widget.meditation.audioPath));
        if (!mounted) return;
        setState(() => isPlaying = true);
      } catch (e) {
        debugPrint('Play error: $e');
      }
    }
  }

  Future<void> seekBackward() async {
    final newPosition = position - const Duration(seconds: 10);
    await audioPlayer.seek(
      newPosition < Duration.zero ? Duration.zero : newPosition,
    );
  }

  Future<void> seekForward() async {
    final newPosition = position + const Duration(seconds: 10);
    await audioPlayer.seek(newPosition > duration ? duration : newPosition);
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final double maxSeconds =
        duration.inSeconds > 0 ? duration.inSeconds.toDouble() : 1.0;
    final double valueSeconds =
        position.inSeconds.clamp(0, maxSeconds.toInt()).toDouble();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n?.guidedMeditationResources ?? "Guided Meditation Resources",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Album Art with responsive aspect ratio
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 1, // square album art
                    child: _PlayerImageOrGradient(item: widget.meditation),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Title and subtitle
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.meditation.title.replaceAll('\n', ' '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.meditation.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Progress Bar + Times
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.secondary,
                        inactiveTrackColor: const Color.fromARGB(
                          60,
                          90,
                          90,
                          90,
                        ),
                        thumbColor: AppColors.secondary,
                        overlayColor: AppColors.secondary.withOpacity(0.2),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 8,
                        ),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        min: 0,
                        max: maxSeconds,
                        value: valueSeconds.isNaN ? 0 : valueSeconds,
                        onChanged: (v) async {
                          if (duration == Duration.zero) return;
                          await audioPlayer.seek(Duration(seconds: v.toInt()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDuration(position),
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            formatDuration(duration),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Controls
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: seekBackward,
                      iconSize: 32,
                      icon: const Icon(Icons.replay_10),
                    ),
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: ElevatedButton(
                        onPressed: playPause,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: AppColors.secondary,
                          padding: EdgeInsets.zero,
                          elevation: 2,
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: seekForward,
                      iconSize: 32,
                      icon: const Icon(Icons.forward_10),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _PlayerImageOrGradient extends StatelessWidget {
  final MeditationItem item;
  const _PlayerImageOrGradient({required this.item});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      item.imagePath,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [item.gradientStart, item.gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }
}
