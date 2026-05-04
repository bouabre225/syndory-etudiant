import 'package:flutter/material.dart';
import '../../components/appNavbarNoReturn.dart';
import '../../components/appBottomNavbar.dart';
import '../../components/apptheme.dart';
import '../../components/reusable/session_card.dart';
import '../../components/reusable/info_row.dart';
import '../../components/reusable/custom_buttons.dart';
import '../../models/session_status.dart';
import '../justificatif/uploadScreen.dart';
import '../../models/justificatifModels.dart';

class DetailSeanceScreen extends StatelessWidget {
  final SessionStatus status;
  final String courseName;
  final String professorName;

  const DetailSeanceScreen({
    super.key,
    required this.status,
    required this.courseName,
    required this.professorName,
  });

  void _showJustifyModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: AppColors.bgPrimary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: JustificatifsUploadScreen(
            absence: AbsenceEnAttente(
              id: '1',
              courseName: courseName,
              date: '14 Octobre',
              timeRange: '2h',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
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
              status: status,
              courseName: courseName,
              professorName: professorName,
            ),
            const SizedBox(height: 16),

            // Infos
            const InfoRow(
              icon: Icons.calendar_month_outlined,
              label: 'DATE & HEURE',
              line1: 'Lundi 14 Octobre',
              line2: '08:30 — 10:30',
            ),
            const SizedBox(height: 12),

            const InfoRow(
              icon: Icons.location_on_outlined,
              label: 'EMPLACEMENT',
              line1: 'Salle 302',
              line2: 'Bâtiment Turing, 3ème étage',
            ),
            const SizedBox(height: 12),

            InfoRow(
              customLeading: const CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=51'),
              ),
              label: 'PROFESSEUR',
              line1: professorName,
            ),
            const SizedBox(height: 20),

            // Actions or Status block depending on status
            if (status == SessionStatus.absence) ...[
              AppPrimaryButton(
                text: 'Justifier une absence',
                icon: Icons.upload_file,
                onPressed: () => _showJustifyModal(context),
              ),
              const SizedBox(height: 20),
            ],

            if (status == SessionStatus.justified) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'STATUT DE TRAITEMENT',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.check_circle, color: AppColors.success, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Validé par l'Administration",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Justificatif médical reçu et validé le 15 Octobre.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Notes de séance
            Row(
              children: const [
                Icon(Icons.notes, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Notes de séance',
                  style: TextStyle(
                    color: AppColors.primary,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lors de cette séance, nous avons exploré la complexité algorithmique des structures de données avancées, notamment les arbres B+ et les graphes pondérés. Un accent particulier a été mis sur l\'algorithme de Dijkstra et ses optimisations.',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),
                  
                  // Pièces jointes
                  _AttachmentItem(
                    icon: Icons.picture_as_pdf,
                    color: Colors.red,
                    name: 'Support_Cours_V3.pdf',
                  ),
                  const SizedBox(height: 10),
                  _AttachmentItem(
                    icon: Icons.folder_zip,
                    color: AppColors.info,
                    name: 'TD_Arbres_Equilibres.zip',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }
}

class _AttachmentItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String name;

  const _AttachmentItem({
    required this.icon,
    required this.color,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.download_rounded, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
