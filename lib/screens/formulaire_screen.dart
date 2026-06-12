// ============================================================
// ÉCRAN 3 : Formulaire création / modification (StatefulWidget)
// - Mode création : aucun argument passé
// - Mode édition  : Annonce passée en argument
// - Validation des champs avant sauvegarde
// Fichier : lib/screens/formulaire_screen.dart
// ============================================================

import 'package:flutter/material.dart';
import '../data/donnees.dart';
import '../models/annonce.dart';

class FormulaireScreen extends StatefulWidget {
  const FormulaireScreen({super.key});

  @override
  State<FormulaireScreen> createState() => _FormulaireScreenState();
}

class _FormulaireScreenState extends State<FormulaireScreen> {
  // Clé du formulaire pour la validation
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs des champs texte
  final _objetController = TextEditingController();
  final _prixController = TextEditingController();

  // État des dropdowns
  Categorie _categorie = Categorie.livre;
  EtatObjet _etat = EtatObjet.bon;
  bool _vendu = false;

  // Mode édition
  bool _estEdition = false;
  bool _initialise = false;
  Annonce? _annonceAModifier;

  // Initialisation des champs si édition (appelé une seule fois)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialise) return;
    _initialise = true;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Annonce) {
      _annonceAModifier = args;
      _estEdition = true;
      _objetController.text = args.objet;
      _prixController.text = args.prix.toString();
      _categorie = args.categorie;
      _etat = args.etat;
      _vendu = args.vendu;
    }
  }

  @override
  void dispose() {
    _objetController.dispose();
    _prixController.dispose();
    super.dispose();
  }

  // Sauvegarde : création ou modification
  void _sauvegarder() {
    // Validation du formulaire
    if (!_formKey.currentState!.validate()) return;

    if (_estEdition && _annonceAModifier != null) {
      // ---- Modification en place ----
      _annonceAModifier!.objet = _objetController.text.trim();
      _annonceAModifier!.categorie = _categorie;
      _annonceAModifier!.prix = int.parse(_prixController.text.trim());
      _annonceAModifier!.etat = _etat;
      _annonceAModifier!.vendu = _vendu;
    } else {
      // ---- Création d'une nouvelle annonce ----
      final nouvelleAnnonce = Annonce(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        objet: _objetController.text.trim(),
        categorie: _categorie,
        prix: int.parse(_prixController.text.trim()),
        etat: _etat,
        vendu: _vendu,
      );
      Donnees.annonces.add(nouvelleAnnonce);
    }

    Navigator.pop(context, true); // true = modifications effectuées
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_estEdition ? 'Modifier l\'annonce' : 'Nouvelle annonce'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // ---- Champ : Nom de l'objet ----
            _labelChamp('Nom de l\'objet'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _objetController,
              style: const TextStyle(color: Colors.white),
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Ex: Casque audio Sony...',
                hintStyle: TextStyle(color: Colors.white24),
                prefixIcon: Icon(Icons.label_outline, color: Colors.white38),
              ),
              validator: (valeur) {
                if (valeur == null || valeur.trim().isEmpty) {
                  return 'Le nom de l\'objet est obligatoire';
                }
                if (valeur.trim().length < 3) {
                  return 'Au moins 3 caractères requis';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // ---- Champ : Prix ----
            _labelChamp('Prix (FCFA)'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _prixController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Ex: 5000',
                hintStyle: TextStyle(color: Colors.white24),
                prefixIcon:
                    Icon(Icons.payments, color: Colors.white38),
                suffixText: 'FCFA',
                suffixStyle: TextStyle(color: Colors.white38),
              ),
              validator: (valeur) {
                if (valeur == null || valeur.trim().isEmpty) {
                  return 'Le prix est obligatoire';
                }
                final prix = int.tryParse(valeur.trim());
                if (prix == null) {
                  return 'Entrez un nombre entier (ex: 5000)';
                }
                if (prix <= 0) {
                  return 'Le prix doit être supérieur à 0';
                }
                if (prix > 10000000) {
                  return 'Prix trop élevé';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // ---- Dropdown : Catégorie ----
            _labelChamp('Catégorie'),
            const SizedBox(height: 8),
            _dropdown<Categorie>(
              valeur: _categorie,
              items: Categorie.values,
              labelBuilder: (cat) => '${cat.emoji}  ${cat.label}',
              onChanged: (val) => setState(() => _categorie = val!),
            ),
            const SizedBox(height: 24),

            // ---- Dropdown : État ----
            _labelChamp('État de l\'objet'),
            const SizedBox(height: 8),
            _dropdown<EtatObjet>(
              valeur: _etat,
              items: EtatObjet.values,
              labelBuilder: (e) => e.label,
              onChanged: (val) => setState(() => _etat = val!),
            ),
            const SizedBox(height: 24),

            // ---- Switch : Marquer comme vendu ----
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.sell,
                      color: Colors.white38, size: 20),
                  const SizedBox(width: 12),
                  const Text(
                    'Marquer comme vendu',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const Spacer(),
                  Switch(
                    value: _vendu,
                    activeColor: const Color(0xFF4CAF50),
                    onChanged: (val) => setState(() => _vendu = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),

            // ---- Bouton Sauvegarder ----
            ElevatedButton.icon(
              onPressed: _sauvegarder,
              icon: Icon(_estEdition ? Icons.save : Icons.add),
              label: Text(
                _estEdition
                    ? 'Enregistrer les modifications'
                    : 'Publier l\'annonce',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),

            // ---- Bouton Annuler ----
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                'Annuler',
                style: TextStyle(color: Colors.white38),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper : label de champ
  Widget _labelChamp(String texte) {
    return Text(
      texte,
      style: const TextStyle(
        color: Colors.white60,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  // Widget helper : dropdown stylisé
  Widget _dropdown<T>({
    required T valeur,
    required List<T> items,
    required String Function(T) labelBuilder,
    required void Function(T?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: valeur,
          dropdownColor: const Color(0xFF2A2A2A),
          style: const TextStyle(color: Colors.white, fontSize: 15),
          isExpanded: true,
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(labelBuilder(item)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
