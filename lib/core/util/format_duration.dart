import 'package:intl/intl.dart';

String formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

String formatTelegramStyle(DateTime dateTime) {
  final localDt = dateTime.toLocal();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final date = DateTime(localDt.year, localDt.month, localDt.day);
  final difference = today.difference(date).inDays;

  if (difference == 0) {
    // Today → show time (e.g., 10:45 AM)
    return DateFormat('HH:mm').format(localDt);
  } else if (difference == 1) {
    // Yesterday
    return 'Yesterday';
  } else if (difference < 7 &&
      date.isAfter(today.subtract(Duration(days: now.weekday)))) {
    // This week → show weekday name (e.g., Mon, Tue)
    return DateFormat.E().format(localDt);
  } else {
    // Older → show like Jul 30, Aug 2
    return DateFormat.MMMd().format(localDt);
  }
}

String formatPrice(dynamic price) {
  print('Formatting price: $price');

  // 1️⃣ Convert to string
  String priceStr = price.toString();

  // 2️⃣ Extract only digits (and optionally decimal point)
  // This removes ETB or any other text
  priceStr = priceStr.replaceAll(RegExp(r'[^0-9.]'), '');

  // 3️⃣ Parse to number
  final number = double.tryParse(priceStr) ?? 0;

  // 4️⃣ Format with commas
  final formatter = NumberFormat('#,###');
  final formatted = formatter.format(number);

  print("Formatted price: $formatted");
  return formatted;
}
