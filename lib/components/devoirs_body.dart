import 'package:flutter/material.dart';
import 'devoir_card.dart';
import 'tab_item.dart';

/// Corps principal de l'écran "Mes Devoirs".
/// Contient les onglets de filtre et la liste des cartes de devoirs.
///
/// [activeTab]     : index de l'onglet actif (0, 1 ou 2).
/// [onTabChanged]  : callback appelé quand l'utilisateur change d'onglet.
/// [devoirs]       : liste des devoirs à afficher.
class DevoirsBody extends StatelessWidget {
  final int activeTab;
  final ValueChanged<int>? onTabChanged;
  final List<Map<String, dynamic>> devoirs;

  const DevoirsBody({
    this.activeTab = 0,
    this.onTabChanged,
    required this.devoirs,
  });

  static const _tabs = ['À faire', 'En cours', 'Terminés'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Onglets de filtre ─────────────────────────────────────
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: List.generate(_tabs.length, (index) {
              return Padding(
                padding: EdgeInsets.only(right: index < _tabs.length - 1 ? 10 : 0),
                child: GestureDetector(
                  onTap: () => onTabChanged?.call(index),
                  child: TabItem(
                    text: _tabs[index],
                    active: activeTab == index,
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 8),

        // ── Liste des devoirs ─────────────────────────────────────
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            itemCount: devoirs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final d = devoirs[index];
              return DevoirCard(
                matiere: d['matiere'] as String,
                titre: d['titre'] as String,
                date: d['date'] as String,
                progression: (d['progression'] as num).toDouble(),
                niveau: d['niveau'] as String,
                couleur: d['couleur'] as Color,
              );
            },
          ),
        ),
      ],
    );
  }
}
