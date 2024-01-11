import 'package:droomy/common/constants.dart';
import 'package:droomy/common/theme.dart';
import 'package:droomy/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebugColorGridScreen extends ConsumerWidget {
  const DebugColorGridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(isDarkModeProvider);

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Colors'),
        actions: const [ThemeSwitch()],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: Constants.paddingSmall,
        crossAxisSpacing: Constants.paddingSmall,
        children: [
          _buildColorTile('Primary', colorScheme.primary),
          _buildColorTile('Primary Container', colorScheme.primaryContainer),
          _buildColorTile('Secondary', colorScheme.secondary),
          _buildColorTile(
              'Secondary Container', colorScheme.secondaryContainer),
          _buildColorTile('Tertiary', colorScheme.tertiary),
          _buildColorTile('Tertiary Container', colorScheme.tertiaryContainer),
          _buildColorTile('Background', colorScheme.background),
          _buildColorTile('Surface', colorScheme.surface),
          _buildColorTile('Error', colorScheme.error),
          _buildColorTile('On Primary', colorScheme.onPrimary),
          _buildColorTile(
              'On Primary Container', colorScheme.onPrimaryContainer),
          _buildColorTile('On Secondary', colorScheme.onSecondary),
          _buildColorTile(
              'On Secondary Container', colorScheme.onSecondaryContainer),
          _buildColorTile('On Tertiary', colorScheme.onTertiary),
          _buildColorTile(
              'On Tertiary Container', colorScheme.onTertiaryContainer),
          _buildColorTile('Shadow ', colorScheme.shadow),
          _buildColorTile('On Surface', colorScheme.onSurface),
          _buildColorTile('Outline', colorScheme.outline),
          _buildColorTile('Outline Variant', colorScheme.outlineVariant),
          _buildColorTile('Surface Variant', colorScheme.surfaceVariant),
        ],
      ),
    );
  }

  Widget _buildColorTile(String name, Color color) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(Constants.paddingSmall),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              color: color,
            ),
            const SizedBox(height: Constants.paddingSmall),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
