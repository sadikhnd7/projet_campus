import '../models/annonce.dart';

class Donnees {
  static List<Annonce> annonces = [
    Annonce(
      id: '1',
      objet: 'Casque audio Sony WH-1000XM3',
      categorie: Categorie.electro,
      prix: 8000,
      etat: EtatObjet.bon,
    ),
    Annonce(
      id: '2',
      objet: 'Livre "Introduction aux Algorithmes" – Cormen',
      categorie: Categorie.livre,
      prix: 6500,
      etat: EtatObjet.bon,
    ),
    Annonce(
      id: '3',
      objet: 'Chaise de bureau à roulettes',
      categorie: Categorie.meuble,
      prix: 15000,
      etat: EtatObjet.use,
    ),
    Annonce(
      id: '4',
      objet: 'Veste en jean taille L',
      categorie: Categorie.vetement,
      prix: 4500,
      etat: EtatObjet.bon,
    ),
    Annonce(
      id: '5',
      objet: 'Calculatrice Casio FX-991ES Plus',
      categorie: Categorie.electro,
      prix: 5000,
      etat: EtatObjet.neuf,
      vendu: true,
    ),
    Annonce(
      id: '6',
      objet: 'Livre "Java EE 7" – Editions ENI',
      categorie: Categorie.livre,
      prix: 3500,
      etat: EtatObjet.use,
    ),
  ];
}
