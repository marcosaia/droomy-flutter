import 'package:flutter/material.dart';

class NumberBadge extends StatelessWidget {
  final int badgeCount;
  final Color color;

  const NumberBadge(
      {super.key, required this.badgeCount, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: const BoxConstraints(
          minWidth: 12,
          minHeight: 12,
        ),
        child: Text(
          '$badgeCount',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
