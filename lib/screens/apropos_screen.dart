import 'package:flutter/material.dart';
import '../data/donnees.dart';
import '../models/annonce.dart';

class AproposScreen extends StatelessWidget {
  const AproposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Calcul des statistiques via la méthode statique du modèle
    final int total = Donnees.annonces.length;
    final int disponibles =
        Donnees.annonces.where((a) => a.estDisponible()).length;
    final double prixMoyen = Annonce.prixMoyen(Donnees.annonces);

    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text('♻️', style: TextStyle(fontSize: 54)),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Bourse aux Objets d\'Occasion',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'ODD 12 — Consommation et production responsables',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF4CAF50),
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),

            _sectionTitre('Informations'),
            const SizedBox(height: 12),
            _cartInfo(Icons.person_outline, 'Étudiant',
                'Ababacar Sadikh Ndoye'),
            _cartInfo(Icons.school, 'Promotion', 'DAR26 — ESMT Dakar'),
            _cartInfo(Icons.storage, 'Source des données',
                'Collecte sur le campus ESMT'),
            _cartInfo(Icons.calendar_today, 'Date de collecte',
                'Juin 2026'),
            const SizedBox(height: 28),

            _sectionTitre('Statistiques'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _statCard('📦', total.toString(), 'Annonces'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                      '✅', disponibles.toString(), 'Disponibles'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    '💰',
                    '${prixMoyen.toStringAsFixed(0)} F',
                    'Prix moyen',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.eco,
                      color: Color(0xFF4CAF50), size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Cette application encourage le réemploi '
                      'des objets sur le campus, réduisant ainsi '
                      'les déchets et favorisant une consommation responsable.',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitre(String texte) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        texte.toUpperCase(),
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _cartInfo(IconData icon, String label, String valeur) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4CAF50), size: 20),
          const SizedBox(width: 14),
          Text(label,
              style:
                  const TextStyle(color: Colors.white38, fontSize: 13)),
          const Spacer(),
          Text(
            valeur,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String emoji, String valeur, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 6),
          Text(
            valeur,
            style: const TextStyle(
              color: Color(0xFF4CAF50),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
