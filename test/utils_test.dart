import 'package:droomy/common/date_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Closest date after days util', () async {
// Test cases
    List<DateTime> testDates = [
      DateTime(2024, 2, 1), // Thursday
      DateTime(2024, 2, 5), // Monday
      DateTime(2024, 2, 6), // Tuesday
      DateTime(2024, 2, 11), // Sunday
      DateTime(2024, 2, 18), // Sunday
      DateTime(2024, 2, 19), // Monday
    ];

    // Expected results (Closest Friday after adding 21 days)
    List<DateTime> expectedResults = [
      DateTime(2024, 2, 23),
      DateTime(2024, 2, 23),
      DateTime(2024, 3, 1),
      DateTime(2024, 3, 1),
      DateTime(2024, 3, 8),
      DateTime(2024, 3, 8),
    ];

    for (int i = 0; i < testDates.length; i++) {
      DateTime result = testDates[i].closestFridayAfter(21);
      assert(result == expectedResults[i],
          'Test case ${i + 1} failed: Expected ${expectedResults[i]}, but got $result');
      print(
          'Test case ${i + 1} passed: closestFridayAfter(${testDates[i]}) = $result');
    }
  });
}
