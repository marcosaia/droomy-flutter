import 'package:droomy/common/constants.dart';
import 'package:droomy/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return GestureDetector(
      onTap: () {
        ref.read(isDarkModeProvider.notifier).state = !isDarkMode;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingRegular,
            vertical: Constants.paddingSmall),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: isDarkMode ? Colors.yellow : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
