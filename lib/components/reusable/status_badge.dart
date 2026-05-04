import 'package:flutter/material.dart';
import '../apptheme.dart';
import '../../models/session_status.dart';

class StatusBadge extends StatelessWidget {
  final SessionStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String text;
    Color bgColor;
    Color textColor;
    IconData? icon;

    switch (status) {
      case SessionStatus.presence:
        text = 'Présence enregistrée';
        bgColor = AppColors.success.withOpacity(0.15);
        textColor = AppColors.success;
        icon = Icons.check_circle_outline;
        break;
      case SessionStatus.absence:
        text = 'Absence observée';
        bgColor = AppColors.danger.withOpacity(0.15);
        textColor = AppColors.danger;
        icon = Icons.cancel_outlined;
        break;
      case SessionStatus.justified:
        text = 'Absence justifiée';
        bgColor = AppColors.orange.withOpacity(0.15);
        textColor = AppColors.orange;
        icon = Icons.info_outline;
        break;
      case SessionStatus.enCours:
        text = 'SÉANCE DE COURS';
        bgColor = Colors.white.withOpacity(0.15);
        textColor = Colors.white70;
        icon = null;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: 14),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: status == SessionStatus.enCours ? 1.2 : 0,
            ),
          ),
        ],
      ),
    );
  }
}
