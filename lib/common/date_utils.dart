class RemainingTime {
  String message;
  bool isImminent;
  bool expired;
  RemainingTime(this.message, this.isImminent, {this.expired = false});
}

extension DateTimeExtension on DateTime {
  RemainingTime remainingTime() {
    DateTime currentDate = DateTime.now();
    Duration difference = this.difference(currentDate);

    if (difference.isNegative) {
      return RemainingTime('BROO 😭', true, expired: true);
    }

    if (difference.inDays > 0) {
      return RemainingTime(
          '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} left',
          difference.inDays < 2);
    }

    if (difference.inHours > 0) {
      return RemainingTime('${difference.inHours} hours left', true);
    }

    if (difference.inMinutes > 0) {
      return RemainingTime('${difference.inMinutes} minutes left', true);
    }

    return RemainingTime('Less than a minute left', true);
  }

  DateTime closestFridayAfter(int days) {
    // Add 21 days to the provided date
    DateTime targetDate = add(Duration(days: days));

    // If it's a friday just return it
    if (targetDate.weekday == 5) {
      return targetDate;
    }

    // Look forward
    if (targetDate.weekday >= 2 && targetDate.weekday < 5) {
      return targetDate.add(Duration(days: 5 - targetDate.weekday));
    }

    // Look backwards
    final diff = targetDate.weekday - 5;
    return targetDate.subtract(Duration(days: diff > 0 ? diff : 3));
  }
}
