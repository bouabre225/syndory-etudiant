import 'package:flutter/material.dart';
import '../../models/session_status.dart';
import 'status_badge.dart';

class SessionCard extends StatelessWidget {
  final SessionStatus status;
  final String courseName;
  final String professorName;

  const SessionCard({
    super.key,
    required this.status,
    required this.courseName,
    required this.professorName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A3C4D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusBadge(status: status),
          const SizedBox(height: 14),
          Text(
            courseName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.person_outline, color: Colors.white60, size: 16),
              const SizedBox(width: 6),
              Text(
                professorName,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
