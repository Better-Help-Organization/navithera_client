import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localization.dart";

String getTimeBasedGreeting(BuildContext context) {
  final hour = DateTime.now().hour;
  final l10n = AppLocalizations.of(context)!;

  if (hour >= 5 && hour < 12) {
    return l10n.goodMorning;
  } else if (hour >= 12 && hour < 17) {
    return l10n.goodAfternoon;
  } else if (hour >= 17 && hour < 21) {
    return l10n.goodEvening;
  } else {
    return l10n.goodNight;
  }
}
