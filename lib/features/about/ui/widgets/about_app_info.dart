import 'package:flutter/material.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';

class AboutAppInfo extends StatelessWidget {
  const AboutAppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About LAZA',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlack,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LAZA is your ultimate shopping destination, bringing you the latest fashion trends and styles right to your fingertips.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: AppColors.lightGray,
                  ),
                ),
                SizedBox(height: 20),
                _InfoRow(
                  icon: Icons.verified_outlined,
                  label: 'Version',
                  value: '1.0.0',
                ),
                SizedBox(height: 16),
                _InfoRow(
                  icon: Icons.code_outlined,
                  label: 'Built with',
                  value: 'Flutter',
                ),
                SizedBox(height: 16),
                _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Released',
                  value: '2026',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBlack,
                  ),
                ),
                const SizedBox(height: 16),
                _buildFeatureItem('Browse latest fashion collections'),
                _buildFeatureItem('Add items to wishlist'),
                _buildFeatureItem('Secure checkout process'),
                _buildFeatureItem('Track your orders'),
                _buildFeatureItem('Manage your profile'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 20,
            color: AppColors.mainColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.lightGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.mainColor,
        ),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBlack,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.lightGray,
          ),
        ),
      ],
    );
  }
}
