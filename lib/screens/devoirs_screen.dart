import 'package:flutter/material.dart';
import '../components/app_navbar.dart';
import '../components/bottom_nav_bar.dart';
import '../components/devoirs_body.dart';

/// Écran principal "Mes Devoirs".
/// Assemble les trois composants : AppNavbar, DevoirsBody et BottomNavBar.
class DevoirsScreen extends StatefulWidget {
  @override
  State<DevoirsScreen> createState() => _DevoirsScreenState();
}

class _DevoirsScreenState extends State<DevoirsScreen> {
  int _activeTab = 0;
  int _activeNav = 1;

  // ── Données statiques (à remplacer par un vrai service/API) ────────────
  final List<Map<String, dynamic>> _devoirs = [
    {
      'matiere': 'MACROÉCONOMIE',
      'titre': 'Analyse de marché',
      'date': 'Demain, 23h59',
      'progression': 0.2,
      'niveau': 'HAUTE',
      'couleur': Colors.red,
    },
    {
      'matiere': 'ALGORITHMIQUE',
      'titre': "Implémentation d'arbres",
      'date': '15 Octobre',
      'progression': 0.0,
      'niveau': 'MOYENNE',
      'couleur': Colors.blue,
    },
    {
      'matiere': 'DROIT DES SOCIÉTÉS',
      'titre': 'Cas Pratique - SARL',
      'date': '20 Octobre',
      'progression': 0.5,
      'niveau': 'BASSE',
      'couleur': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),

      // ── 1. Barre de navigation supérieure ─────────────────────
      appBar: AppNavbar(title: 'Mes Devoirs'),

      // ── 2. Corps principal ─────────────────────────────────────
      body: DevoirsBody(
        activeTab: _activeTab,
        devoirs: _devoirs,
        onTabChanged: (index) => setState(() => _activeTab = index),
      ),

      // ── 3. Barre de navigation inférieure ─────────────────────
      bottomNavigationBar: BottomNavBar(
        currentIndex: _activeNav,
        onTap: (index) => setState(() => _activeNav = index),
      ),
    );
  }
}