import 'package:flutter/material.dart';
import 'package:syndory_etudiant/components/appBottomNavbar.dart';
import 'package:syndory_etudiant/components/apptheme.dart';
import 'package:syndory_etudiant/screens/attendanceScreen.dart';
import 'package:syndory_etudiant/screens/emptyAttendanceScreen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assiduité',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AppShell(),
    );
  }
}

/// Shell principal — IndexedStack conserve l'état de chaque onglet.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  void _onNavTap(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // 0 – Accueil
          _PlaceholderPage(
            label: 'Accueil',
            icon: Icons.home_rounded,
            navIndex: _currentIndex,
            onNavTap: _onNavTap,
          ),
          // 1 – Cours
          _PlaceholderPage(
            label: 'Cours',
            icon: Icons.book_rounded,
            navIndex: _currentIndex,
            onNavTap: _onNavTap,
          ),
          // 2 – Assiduité  ← nos deux écrans ici
          _AttendanceTab(
            navIndex: _currentIndex,
            onNavTap: _onNavTap,
          ),
          // 3 – Notifications
          _PlaceholderPage(
            label: 'Notifications',
            icon: Icons.notifications_rounded,
            navIndex: _currentIndex,
            onNavTap: _onNavTap,
          ),
          // 4 – Profil
          _PlaceholderPage(
            label: 'Profil',
            icon: Icons.person_rounded,
            navIndex: _currentIndex,
            onNavTap: _onNavTap,
          ),
        ],
      ),
    );
  }
}

/// Onglet Assiduité : Navigator interne pour passer de l'état vide → rempli.
class _AttendanceTab extends StatefulWidget {
  final int navIndex;
  final ValueChanged<int> onNavTap;

  const _AttendanceTab({required this.navIndex, required this.onNavTap});

  @override
  State<_AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<_AttendanceTab> {
  /// true = données disponibles, false = état vide
  bool _hasData = false;

  @override
  Widget build(BuildContext context) {
    if (_hasData) {
      return AttendanceScreen(
        navIndex: widget.navIndex,
        onNavTap: widget.onNavTap,
      );
    }

    return EmptyAttendanceScreen(
      navIndex: widget.navIndex,
      onNavTap: widget.onNavTap,
      // Simule le chargement des données au refresh
      onRefresh: () => setState(() => _hasData = true),
    );
  }
}

/// Page placeholder pour les onglets non encore implémentés.
class _PlaceholderPage extends StatelessWidget {
  final String label;
  final IconData icon;
  final int navIndex;
  final ValueChanged<int> onNavTap;

  const _PlaceholderPage({
    required this.label,
    required this.icon,
    required this.navIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.textMuted, size: 48),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navIndex,
        onTap: onNavTap,
      ),
    );
  }
}