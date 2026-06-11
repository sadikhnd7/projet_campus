enum Categorie { livre, electro, meuble, vetement }

enum EtatObjet { neuf, bon, use }


extension CategorieExt on Categorie {
  String get label {
    switch (this) {
      case Categorie.livre:
        return 'Livre';
      case Categorie.electro:
        return 'Électro';
      case Categorie.meuble:
        return 'Meuble';
      case Categorie.vetement:
        return 'Vêtement';
    }
  }

  String get emoji {
    switch (this) {
      case Categorie.livre:
        return '📚';
      case Categorie.electro:
        return '💻';
      case Categorie.meuble:
        return '🪑';
      case Categorie.vetement:
        return '👕';
    }
  }
}

extension EtatExt on EtatObjet {
  String get label {
    switch (this) {
      case EtatObjet.neuf:
        return 'Neuf';
      case EtatObjet.bon:
        return 'Bon état';
      case EtatObjet.use:
        return 'Usé';
    }
  }
}


class Annonce {
  final String id;
  String objet;
  Categorie categorie;
  int prix; // en FCFA
  EtatObjet etat;
  bool vendu;

  Annonce({
    required this.id,
    required this.objet,
    required this.categorie,
    required this.prix,
    required this.etat,
    this.vendu = false,
  });

  
  String prixFormate() {
    if (prix >= 1000) {
      final milliers = prix ~/ 1000;
      final reste = prix % 1000;
      if (reste == 0) return '$milliers 000 FCFA';
      return '$milliers ${reste.toString().padLeft(3, '0')} FCFA';
    }
    return '$prix FCFA';
  }

  bool estDisponible() => !vendu;

  static double prixMoyen(List<Annonce> liste) {
    if (liste.isEmpty) return 0.0;
    final total = liste.map((a) => a.prix).reduce((a, b) => a + b);
    return total / liste.length;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'objet': objet,
      'categorie': categorie.name,
      'prix': prix,
      'etat': etat.name,
      'vendu': vendu,
    };
  }
}
