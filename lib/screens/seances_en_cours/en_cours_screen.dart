import 'package:flutter/material.dart';
import '../../components/reusable/session_card.dart';
import '../../components/reusable/info_row.dart';
import '../../components/reusable/custom_buttons.dart';
import '../../models/session_status.dart';
import '../../components/apptheme.dart';
import '../../components/appBottomNavbar.dart';

enum GpsState { initial, searching, confirmed, error }

class EnCoursScreen extends StatefulWidget {
  final String courseName;
  final String professorName;

  const EnCoursScreen({
    super.key,
    this.courseName = 'Algorithmique\nAvancée',
    this.professorName = 'Prof. Jean Dupont',
  });

  @override
  State<EnCoursScreen> createState() => _EnCoursScreenState();
}

class _EnCoursScreenState extends State<EnCoursScreen> {
  GpsState _gpsState = GpsState.initial;

  static const Color _orange = Color(0xFFFF6B35);
  static const Color _darkTeal = Color(0xFF1A3C4D);
  static const Color _red = Color(0xFFE53935);

  void _startSearching() {
    setState(() => _gpsState = GpsState.searching);
  }

  void _simulateConfirmed() {
    setState(() => _gpsState = GpsState.confirmed);
  }

  void _simulateError() {
    setState(() => _gpsState = GpsState.error);
  }

  void _goBackToDashboard() {
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            if (_gpsState != GpsState.initial) {
              setState(() => _gpsState = GpsState.initial);
            } else {
              Navigator.of(context).maybePop();
            }
          },
          child: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        title: const Text(
          'Détails de la séance',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SessionCard(
              status: SessionStatus.enCours,
              courseName: widget.courseName,
              professorName: widget.professorName,
            ),
            const SizedBox(height: 12),

            // Bandeau EN COURS
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  left: BorderSide(color: _orange, width: 3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.calendar_today, color: _orange, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'EN COURS',
                        style: TextStyle(
                          color: _orange,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Session ouverte maintenant',
                        style: TextStyle(
                          color: _darkTeal,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Date & heure
            const InfoRow(
              icon: Icons.calendar_month_outlined,
              label: 'DATE & HEURE',
              line1: 'Lundi 14 Octobre',
              line2: '08:30 — 10:30',
            ),
            const SizedBox(height: 12),

            // Emplacement
            const InfoRow(
              icon: Icons.location_on_outlined,
              label: 'EMPLACEMENT',
              line1: 'Salle 302',
              line2: 'Bâtiment Turing, 3ème étage',
            ),
            const SizedBox(height: 12),

            // Professeur
            InfoRow(
              customLeading: const CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=51',
                ),
              ),
              label: 'PROFESSEUR',
              line1: widget.professorName,
            ),
            const SizedBox(height: 20),

            // Dynamic bottom part based on state
            _buildBottomContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomContent() {
    switch (_gpsState) {
      case GpsState.initial:
        return _buildInitialState();
      case GpsState.searching:
        return _buildSearchingState();
      case GpsState.confirmed:
        return _buildConfirmedState();
      case GpsState.error:
        return _buildErrorState();
    }
  }

  Widget _buildInitialState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.menu, color: _orange, size: 20),
            SizedBox(width: 8),
            Text(
              'Notes de séance',
              style: TextStyle(
                color: _darkTeal,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Merci de prévoir vos ordinateurs portables. Nous aborderons la complexité spatio-temporelle des algorithmes de tri récursifs. Un support de cours sera distribué en fin de séance.',
            style: TextStyle(
              color: Color(0xFF555555),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 28),
        AppPrimaryButton(
          text: 'Marquer ma présence',
          icon: Icons.how_to_reg,
          onPressed: _startSearching,
        ),
        const SizedBox(height: 12),
        AppSecondaryButton(
          text: 'Justifier une absence',
          icon: Icons.description_outlined,
          onPressed: () {},
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSearchingState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CARTE 1 — Timer
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _orange, width: 6),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '12:45',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w700,
                            color: _orange,
                          ),
                        ),
                        Text(
                          'MINUTES',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'TEMPS DE VALIDATION RESTANT',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // CARTE 2 — GPS
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: const Border(
              left: BorderSide(color: _orange, width: 3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.location_on, color: _orange, size: 18),
                  SizedBox(width: 10),
                  Text(
                    'Recherche de votre position GPS...',
                    style: TextStyle(
                      color: _darkTeal,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(_orange),
                  minHeight: 5,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: Colors.grey, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(text: 'Rayon de tolérance : '),
                          TextSpan(
                            text: '50m',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _darkTeal,
                            ),
                          ),
                          TextSpan(
                            text: '. Veuillez rester à proximité immédiate de la salle.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // CARTE 3 — Map
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: const Color(0xFF6B8A9E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _orange.withOpacity(0.15),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _orange.withOpacity(0.25),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _orange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Boutons de simulation
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _simulateConfirmed,
            style: ElevatedButton.styleFrom(
              backgroundColor: _orange,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Simuler — Présence confirmée',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _simulateError,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: const Text(
              'Simuler — Erreur de localisation',
              style: TextStyle(
                color: _darkTeal,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildConfirmedState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xFFFFE8E0),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle,
            color: _orange,
            size: 64,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Présence confirmée !',
          style: TextStyle(
            color: _darkTeal,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Votre présence au cours de ${widget.courseName.replaceAll('\n', ' ')} a été enregistrée avec succès.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _goBackToDashboard,
            style: ElevatedButton.styleFrom(
              backgroundColor: _orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Retour au tableau de bord',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildErrorState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          width: 110,
          height: 110,
          decoration: const BoxDecoration(
            color: Color(0xFFFFE8E8),
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.location_off,
                color: Colors.red.shade300,
                size: 58,
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: _red, size: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Erreur de localisation',
          style: TextStyle(
            color: _red,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.6),
              children: [
                TextSpan(text: 'Vous êtes hors du rayon autorisé. Pour valider votre présence, vous devez vous situer à moins de '),
                TextSpan(
                  text: '50m',
                  style: TextStyle(fontWeight: FontWeight.w700, color: _darkTeal),
                ),
                TextSpan(text: ' de la salle de classe.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.social_distance, color: _orange, size: 16),
            SizedBox(width: 6),
            Text('Distance estimée : ', style: TextStyle(color: Colors.grey, fontSize: 13)),
            Text('142m', style: TextStyle(color: _darkTeal, fontSize: 13, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              setState(() => _gpsState = GpsState.searching);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: const Text(
              'Réessayer',
              style: TextStyle(
                color: _darkTeal,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
