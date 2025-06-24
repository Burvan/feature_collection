final class TimeFormatter {
  static String formatTime(DateTime time) {
    final DateTime now = DateTime.now();

    final bool isToday =
        now.day == time.day && now.month == time.month && now.year == time.year;

    if (isToday) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      return '${time.day.toString().padLeft(2, '0')}.${time.month.toString().padLeft(2, '0')}';
    }
  }
}
