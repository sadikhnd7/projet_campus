import 'package:flutter/material.dart';
import '../data/donnees.dart';
import '../models/annonce.dart';
import '../widgets/badge_etat.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final annonce =
        ModalRoute.of(context)!.settings.arguments as Annonce;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Modifier',
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                '/formulaire',
                arguments: annonce,
              );
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    annonce.categorie.emoji,
                    style: const TextStyle(fontSize: 52),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              annonce.objet,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              annonce.categorie.label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white38,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 30),
            const Divider(color: Colors.white12),
            const SizedBox(height: 16),

            _ligneInfo(
              Icons.payments,
              'Prix',
              annonce.prixFormate(),
              valueColor: const Color(0xFF4CAF50),
              valueFontSize: 20,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(Icons.star_outline,
                    color: Colors.white38, size: 20),
                const SizedBox(width: 14),
                const Text('État',
                    style: TextStyle(color: Colors.white38, fontSize: 14)),
                const Spacer(),
                BadgeEtat(etat: annonce.etat),
              ],
            ),
            const SizedBox(height: 16),

            _ligneInfo(
              Icons.sell,
              'Statut',
              annonce.vendu ? 'Vendu' : 'Disponible',
              valueColor: annonce.vendu
                  ? const Color(0xFFF44336)
                  : const Color(0xFF4CAF50),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white12),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A1010),
                  foregroundColor: const Color(0xFFF44336),
                  side: const BorderSide(color: Color(0xFFF44336)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.delete_outline),
                label: const Text(
                  'Supprimer cette annonce',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => _confirmerSuppression(context, annonce),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ligneInfo(
    IconData icon,
    String label,
    String valeur, {
    Color? valueColor,
    double valueFontSize = 15,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white38, size: 20),
        const SizedBox(width: 14),
        Text(label,
            style: const TextStyle(color: Colors.white38, fontSize: 14)),
        const Spacer(),
        Text(
          valeur,
          style: TextStyle(
            color: valueColor ?? Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: valueFontSize,
          ),
        ),
      ],
    );
  }

  Future<void> _confirmerSuppression(
      BuildContext context, Annonce annonce) async {
    final confirme = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Confirmer la suppression',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Voulez-vous vraiment supprimer l\'annonce\n"${annonce.objet}" ?\n\nCette action est irréversible.',
          style: const TextStyle(color: Colors.white60, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler',
                style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Supprimer',
              style: TextStyle(
                color: Color(0xFFF44336),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirme == true) {
      Donnees.annonces.removeWhere((a) => a.id == annonce.id);
      if (context.mounted) Navigator.pop(context);
    }
  }
}
