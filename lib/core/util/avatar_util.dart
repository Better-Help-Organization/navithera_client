import 'dart:math';

import 'dart:developer' as Mathx;
import 'package:flutter/material.dart';
import 'package:navithera_client/core/theme/app_colors.dart';

String initials(String s) {
  if (s.trim().isEmpty) return '?';
  final parts = s.trim().split(RegExp(r'\s+'));
  final first = parts.first.characters.first;
  final last = parts.length > 1 ? parts.last.characters.first : '';
  return (first + last).toUpperCase().substring(0, 1);
}

void errMsgD(dynamic s) {
  Mathx.log('print print ${s}');
}

List<Color> getRandomGradient() {
  final gradients = [
    [Colors.teal, AppColors.primary],
    // [const Color(0xFFF08BA6), const Color(0xFFF7A7A0)],
    // [const Color(0xFF827CFF), const Color(0xFFA06BFF)],
  ];
  return gradients[Random().nextInt(gradients.length)];
}

String truncate(String input, [int maxLength = 10]) {
  if (input.length <= maxLength) return input;
  return input.substring(0, maxLength) + '...';
}

String getAvatarImage(int index) {
  // clamp index to range 0–5
  final clampedIndex = index.clamp(0, 5);
  final number = (clampedIndex + 1).toString().padLeft(2, '0');
  return 'assets/images/avatars/generic_img_$number.jpg';
}
