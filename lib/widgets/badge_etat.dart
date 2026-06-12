

import 'package:flutter/material.dart';
import '../models/annonce.dart';

class BadgeEtat extends StatelessWidget {
  final EtatObjet etat;

  const BadgeEtat({super.key, required this.etat});

  Color get _couleur {
    switch (etat) {
      case EtatObjet.neuf:
        return const Color(0xFF4CAF50); // Vert
      case EtatObjet.bon:
        return const Color(0xFFFF9800); // Orange
      case EtatObjet.use:
        return const Color(0xFFF44336); // Rouge
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _couleur.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _couleur, width: 1.2),
      ),
      child: Text(
        etat.label,
        style: TextStyle(
          color: _couleur,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
