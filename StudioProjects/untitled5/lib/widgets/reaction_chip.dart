import 'package:flutter/material.dart';

class ReactionChip extends StatelessWidget {
  final String label;
  final Function(String) onTap;

  const ReactionChip({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
