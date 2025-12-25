import "package:flutter/material.dart";
import "package:navithera_client/l10n/app_localizations.dart";
import 'package:lottie/lottie.dart';

class Step3 extends StatelessWidget {
  const Step3({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF95CCBB), // Softer, more sage-like top
            Color(0xFF5C9182), // Muted forest green bottom
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.15),
          Lottie.asset(
            'assets/animations/page3.json',
            width: size.width * 0.8,
            height: size.height * 0.4,
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.yourJourneyStartsNow,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  width: 60.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  AppLocalizations.of(context)!.healingJourneyDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
