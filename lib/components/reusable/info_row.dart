import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String line1;
  final String? line2;
  final Widget? customLeading;

  const InfoRow({
    super.key,
    this.icon,
    required this.label,
    required this.line1,
    this.line2,
    this.customLeading,
  }) : assert(icon != null || customLeading != null, 'Either icon or customLeading must be provided');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (customLeading != null) 
            customLeading!
          else if (icon != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.grey.shade500, size: 18),
            ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                line1,
                style: const TextStyle(
                  color: Color(0xFF1A3C4D),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (line2 != null)
                Text(
                  line2!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
