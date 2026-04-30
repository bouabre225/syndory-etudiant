import 'package:flutter/material.dart';

/// Carte représentant une matière.
/// Réutilisable partout dans l'app.
///
/// [nom]           : intitulé de la matière
/// [badge]         : libellé court (ex: 'INFOS', 'MATHS')
/// [couleurBadge]  : couleur du badge
/// [assiduite]     : taux d'assiduité entre 0.0 et 1.0
/// [prof]          : nom du professeur
/// [coefficient]   : coefficient de la matière
/// [progression]   : avancement du cours entre 0.0 et 1.0
/// [avatarIcon]    : icône de l'avatar du professeur
class MatiereCard extends StatelessWidget {
  final String nom;
  final String badge;
  final Color couleurBadge;
  final double assiduite;   // entre 0.0 et 1.0
  final String prof;
  final int coefficient;
  final double progression; // entre 0.0 et 1.0
  final IconData avatarIcon;

  const MatiereCard({
    required this.nom,
    required this.badge,
    required this.couleurBadge,
    required this.assiduite,
    required this.prof,
    required this.coefficient,
    required this.progression,
    this.avatarIcon = Icons.person,
  });

  /// Couleur de l'assiduité selon le taux
  Color get _couleurAssiduite {
    if (assiduite >= 0.80) return const Color(0xFF2ECC71);  // vert
    if (assiduite >= 0.50) return const Color(0xFFF39C12);  // orange
    return const Color(0xFFE74C3C);                          // rouge
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(
          left: BorderSide(color: couleurBadge, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── En-tête : badge + assiduité ───────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Badge de catégorie (ex: INFOS, MATHS)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: couleurBadge.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: couleurBadge,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              // Taux d'assiduité
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'ASSIDUITÉ',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '${(assiduite * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _couleurAssiduite,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // ── Nom de la matière ────────────────────────────────────────────
          Text(
            nom,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 10),

          // ── Prof + coefficient ───────────────────────────────────────────
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: couleurBadge.withOpacity(0.15),
                child: Icon(avatarIcon, size: 16, color: couleurBadge),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prof,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Coefficient: $coefficient',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Barre de progression du cours ────────────────────────────────
          Row(
            children: [
              const Text(
                'Progression du cours',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              Text(
                '${(progression * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progression,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
