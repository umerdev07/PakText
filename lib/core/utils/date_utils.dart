import 'package:intl/intl.dart';

class DateUtilss {
  /// Format DateTime string to readable format: "09 Jan 2026, 02:35 PM"
  static String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (e) {
      // Return original string if parsing fails
      return dateString;
    }
  }

  /// Format just date: "09 Jan 2026"
  static String formatDateOnly(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  /// Format just time: "02:35 PM"
  static String formatTimeOnly(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }

  /// Returns relative "time ago" string: "2 hours ago"
  static String timeAgo(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      Duration diff = DateTime.now().difference(date);

      if (diff.inSeconds < 60) return 'just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
      if (diff.inHours < 24) return '${diff.inHours} hours ago';
      if (diff.inDays < 7) return '${diff.inDays} days ago';

      return formatDateOnly(dateString);
    } catch (e) {
      return dateString;
    }
  }
}
