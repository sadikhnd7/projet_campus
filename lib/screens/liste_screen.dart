import 'package:flutter/material.dart';
import '../data/donnees.dart';
import '../models/annonce.dart';
import '../widgets/annonce_card.dart';

class ListeScreen extends StatefulWidget {
  const ListeScreen({super.key});

  @override
  State<ListeScreen> createState() => _ListeScreenState();
}

class _ListeScreenState extends State<ListeScreen> {
  Categorie? _filtreCategorie;

  bool _seulementDisponibles = false;

  List<Annonce> get _annoncesFiltrees {
    return Donnees.annonces.where((annonce) {
      final okCategorie =
          _filtreCategorie == null || annonce.categorie == _filtreCategorie;
      final okDispo =
          !_seulementDisponibles || annonce.estDisponible();
      return okCategorie && okDispo;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '♻️  Bourse Campus',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'À propos',
            onPressed: () => Navigator.pushNamed(context, '/apropos'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBarreFiltres(),

          _buildToggleDisponibles(),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Text(
              '${_annoncesFiltrees.length} annonce(s) trouvée(s)',
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),

          Expanded(
            child: _annoncesFiltrees.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🔍', style: TextStyle(fontSize: 48)),
                        SizedBox(height: 12),
                        Text(
                          'Aucune annonce trouvée',
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 100),
                    itemCount: _annoncesFiltrees.length,
                    itemBuilder: (context, index) {
                      final annonce = _annoncesFiltrees[index];
                      return AnnonceCard(
                        annonce: annonce,
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: annonce,
                          );
                          setState(() {});
                        },
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, '/formulaire');
          setState(() {}); // Rafraîchir après ajout
        },
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle annonce'),
      ),
    );
  }

  Widget _buildBarreFiltres() {
    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          // Chip "Tout"
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('Tout'),
              selected: _filtreCategorie == null,
              onSelected: (_) => setState(() => _filtreCategorie = null),
            ),
          ),
          ...Categorie.values.map(
            (cat) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text('${cat.emoji} ${cat.label}'),
                selected: _filtreCategorie == cat,
                onSelected: (selectionne) => setState(() {
                  _filtreCategorie = selectionne ? cat : null;
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleDisponibles() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
      child: Row(
        children: [
          Switch(
            value: _seulementDisponibles,
            activeColor: const Color(0xFF4CAF50),
            onChanged: (valeur) =>
                setState(() => _seulementDisponibles = valeur),
          ),
          const Text(
            'Disponibles seulement',
            style: TextStyle(color: Colors.white60, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
