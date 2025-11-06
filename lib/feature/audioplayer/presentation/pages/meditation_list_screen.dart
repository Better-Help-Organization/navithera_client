import 'package:flutter/material.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'meditation_player_screen.dart';
import "package:flutter_gen/gen_l10n/app_localization.dart";

// Data model for a meditation item.
class MeditationItem {
  final String title; // Multi‑line allowed; use \n to force breaks if you want
  final String subtitle; // Small category text under the title
  final String imagePath; // Asset image shown at top of card
  final String audioPath; // Path to audio asset (used by player screen)
  final Color gradientStart; // Gradient fallback color if image missing
  final Color gradientEnd;

  const MeditationItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.audioPath,
    required this.gradientStart,
    required this.gradientEnd,
  });
}

/// Main list screen.
class MeditationListScreen extends StatelessWidget {
  MeditationListScreen({super.key});

  // Sample data. Replace the image/audio asset paths with your actual files.
  final List<MeditationItem> meditations = const [
    MeditationItem(
      title: "Rain Therapy: Calm Your Mind in 15 Minutes",
      subtitle: "rainfall",
      imagePath: "assets/images/rain.png",
      audioPath: "sounds/rain_therapy.mp3",
      gradientStart: Color(0xFF4A6CF7),
      gradientEnd: Color(0xFF9B59B6),
    ),
    MeditationItem(
      title: "Potential Meditation",
      subtitle: "Potential",
      imagePath: "assets/images/potential.png",
      audioPath: "sounds/potential_meditation.mp3",
      gradientStart: Color(0xFF2C3E50),
      gradientEnd: Color(0xFF4A90E2),
    ),
    MeditationItem(
      title: "Higher Power Meditation",
      subtitle: "Spiritual",
      imagePath: "assets/images/higher_power.png",
      audioPath: "sounds/higher_power.mp3",
      gradientStart: Color(0xFF667EEA),
      gradientEnd: Color(0xFF764BA2),
    ),
    MeditationItem(
      title: "Healing Meditation",
      subtitle: "Healing",
      imagePath: "assets/images/healing.png",
      audioPath: "sounds/healing_meditation.mp3",
      gradientStart: Color(0xFF4FACFE),
      gradientEnd: Color(0xFF00F2FE),
    ),
    MeditationItem(
      title: "Quiet the Mind Meditation",
      subtitle: "Calm",
      imagePath: "assets/images/quiet_mind.png",
      audioPath: "sounds/quiet_mind.mp3",
      gradientStart: Color(0xFF43E97B),
      gradientEnd: Color(0xFF38F9D7),
    ),
    MeditationItem(
      title: "Meditation for Serenity",
      subtitle: "Serenity",
      imagePath: "assets/images/serenity.png",
      audioPath: "sounds/serenity.mp3",
      gradientStart: Color(0xFFFA709A),
      gradientEnd: Color(0xFFFEE140),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Color appBarColor = AppColors.primary; // dark indigo/navy
    final Color pageBg = const Color(0xFFF4F5F7); // light grey like screenshot

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.guidedMeditationResources,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //guidedMeditationResources
            Text(
              // 'Select from our list of curated sounds just for you curatedSounds.',
              AppLocalizations.of(context)!.curatedSounds,
              style: TextStyle(
                color: Color(0xFF6B7280), // grey
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            _MeditationGrid(
              items: meditations,
              horizontalGap: 16,
              verticalGap: 20,
              onItemTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MeditationPlayerScreen(meditation: item),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays items in 2‑column *rows* whose height expands to fit the tallest card
/// in the row. Exactly the behavior you described: if one card's title is long,
/// the row grows and its neighbor matches the height.
class _MeditationGrid extends StatelessWidget {
  final List<MeditationItem> items;
  final double horizontalGap;
  final double verticalGap;
  final ValueChanged<MeditationItem> onItemTap;

  const _MeditationGrid({
    required this.items,
    required this.onItemTap,
    this.horizontalGap = 16,
    this.verticalGap = 16,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += 2) {
      final itemA = items[i];
      final itemB = (i + 1 < items.length) ? items[i + 1] : null;

      rows.add(
        Padding(
          padding: EdgeInsets.only(
            bottom: i + 2 < items.length ? verticalGap : 0,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _MeditationCard(
                    meditation: itemA,
                    onTap: () => onItemTap(itemA),
                  ),
                ),
                SizedBox(width: horizontalGap),
                Expanded(
                  child:
                      itemB == null
                          ? const SizedBox.shrink()
                          : _MeditationCard(
                            meditation: itemB,
                            onTap: () => onItemTap(itemB),
                          ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}

/// Individual card widget.
class _MeditationCard extends StatelessWidget {
  final MeditationItem meditation;
  final VoidCallback onTap;

  const _MeditationCard({required this.meditation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 16;
    const double imageHeight = 92; // adjust to taste; screenshot ~100ish

    final card = Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image / gradient area
            SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: _MeditationImageOrGradient(meditation: meditation),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: _CardTextSection(meditation: meditation),
            ),
          ],
        ),
      ),
    );

    return card;
  }
}

/// Top visual of the card: show asset image if it exists; otherwise gradient fallback.
class _MeditationImageOrGradient extends StatelessWidget {
  final MeditationItem meditation;
  const _MeditationImageOrGradient({required this.meditation});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      meditation.imagePath,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        // Fallback gradient if asset missing
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [meditation.gradientStart, meditation.gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }
}

/// Text + play icon layout under the image.
class _CardTextSection extends StatelessWidget {
  final MeditationItem meditation;
  const _CardTextSection({required this.meditation});

  @override
  Widget build(BuildContext context) {
    // We'll stack title + bottom row (subtitle + icon).
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title wraps freely; no maxLines so row height grows as needed
        Text(
          meditation.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                meditation.subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            _PlayCircleMini(),
          ],
        ),
      ],
    );
  }
}

class _PlayCircleMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.black54, width: 1.5),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.play_arrow, size: 16, color: Colors.black54),
    );
  }
}
