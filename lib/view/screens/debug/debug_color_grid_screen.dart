import 'package:flutter/material.dart';

class DebugColorGridScreen extends StatelessWidget {
  const DebugColorGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Colors'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: [
          _buildColorTile('Primary', colorScheme.primary),
          _buildColorTile('Primary Container', colorScheme.primaryContainer),
          _buildColorTile('Secondary', colorScheme.secondary),
          _buildColorTile(
              'Secondary Container', colorScheme.secondaryContainer),
          _buildColorTile('Background', colorScheme.background),
          _buildColorTile('Surface', colorScheme.surface),
          _buildColorTile('Error', colorScheme.error),
        ],
      ),
    );
  }

  Widget _buildColorTile(String name, Color color) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              color: color,
            ),
            const SizedBox(height: 8),
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
