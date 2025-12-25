import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import "package:navithera_client/l10n/app_localizations.dart";

class ToolsScreen extends ConsumerWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.toolsResources,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Row 1: Diary and Breath Exercise
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildToolCard(
                      context,
                      title: AppLocalizations.of(context)!.diary,
                      description:
                          AppLocalizations.of(context)!.documentThoughts,
                      icon:
                          Icons
                              .favorite_border, // Using a heart outline for diary
                      //  color: AppColors.secondary,
                      ref: ref, // Dark blue background
                      navigate: "/journal",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildToolCard(
                      context,
                      title: AppLocalizations.of(context)!.breathExercise,
                      description: AppLocalizations.of(context)!.reduceAnxiety,
                      icon: Icons.timer, // Using a timer icon
                      //   color: const Color(0xFF3F3F72),
                      ref: ref, // Dark blue background
                      navigate: "/breathing-intro",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Row 2: Meditate and Community
              Row(
                children: [
                  Expanded(
                    child: _buildToolCard(
                      context,
                      title: AppLocalizations.of(context)!.meditate,
                      description:
                          AppLocalizations.of(context)!.guidedMeditation,
                      icon:
                          Icons
                              .graphic_eq, // Using a bar chart for meditate, can be replaced
                      // color: const Color(0xFF3F3F72),
                      ref: ref, // Dark blue background
                      navigate: "/meditationList",
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Expanded(child: Text("")),
                  Expanded(
                    child: _buildToolCard(
                      context,
                      title: "Community",
                      description: "Comming soon with a lot of new features",
                      icon:
                          Icons
                              .groups_outlined, // Using a bar chart for meditate, can be replaced
                      // color: const Color(0xFF3F3F72),
                      ref: ref, // Dark blue background
                      isComingSoon: true,
                      //  navigate: "/meditationList",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    // required Color color,
    required WidgetRef ref,
    String? navigate,
    bool isComingSoon = false,
  }) {
    final router = ref.read(routerProvider);
    return Container(
      // width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 10,
        //     offset: Offset(0, 5),
        //   ),
        // ],
      ),
      child: GestureDetector(
        onTap: () {
          if (navigate != null) {
            router.push(navigate);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: isComingSoon ? Colors.grey[350] : AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Icon(
                  icon, // A similar vertical bar icon
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF1D1F3F),
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.black54),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
