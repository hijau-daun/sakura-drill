import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('SakuraDrill', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=fajar')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Profile Header
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/300?u=fajar'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Color(0xFF6B585D), shape: BoxShape.circle),
                  child: const Icon(Icons.local_fire_department, color: Colors.white, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Fajar', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Text('fajar.dev@sakuradrill.jp', style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                side: const BorderSide(color: AppColors.divider),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text('Edit Profile', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 40),

            // Proficiency Card
            _buildInfoCard(
              title: 'PROFICIENCY',
              mainValue: 'Level 24',
              subtitle: 'Intermediate Kanji Path',
              showProgress: true,
              progressValue: 0.65,
              icon: Icons.school_outlined,
              cardColor: const Color(0xFFF7F4F4),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                // Total Effort Card
                _buildSmallInfoCard(
                  title: 'TOTAL EFFORT',
                  value: '12,450',
                  unit: 'XP Earned',
                  trend: '+240 today',
                  cardColor: const Color(0xFFF9E7E9),
                  icon: Icons.star_border,
                ),
                const SizedBox(width: 16),
                // Current Ritual Card
                _buildSmallInfoCard(
                  title: 'CURRENT RITUAL',
                  value: '18 Days',
                  unit: 'Your longest streak yet.',
                  trend: 'Keep it up!',
                  cardColor: const Color(0xFFE8F1E9),
                  icon: Icons.local_fire_department,
                  iconColor: const Color(0xFF4C7B52),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Badges Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Badges', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('View all', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildBadgeItem('Kanji Master', Icons.history_edu, const Color(0xFFFFE4BC)),
                const SizedBox(width: 16),
                _buildBadgeItem('Grammar Guru', Icons.auto_awesome, const Color(0xFFE8F1F9)),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String mainValue,
    required String subtitle,
    required bool showProgress,
    required double progressValue,
    required IconData icon,
    required Color cardColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(32)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1)),
          const SizedBox(height: 12),
          Text(mainValue, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
          if (showProgress) ...[
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progressValue,
                minHeight: 10,
                backgroundColor: Colors.white,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6B585D)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSmallInfoCard({
    required String title,
    required String value,
    required String unit,
    required String trend,
    required Color cardColor,
    required IconData icon,
    Color? iconColor,
  }) {
    return Expanded(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(32)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5)),
            const Spacer(),
            Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(unit, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const Spacer(),
            Row(
              children: [
                if (iconColor != null) Icon(icon, color: iconColor, size: 16),
                if (iconColor != null) const SizedBox(width: 4),
                Text(trend, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: iconColor ?? AppColors.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeItem(String label, IconData icon, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.orange.shade800),
            ),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home, 'Home', false),
          _navItem(Icons.auto_stories, 'Study', false),
          _navItem(Icons.bar_chart, 'Progress', false),
          _navItem(Icons.person, 'Profile', true),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.sakuraPink.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: isActive ? AppColors.sakuraDeepPink : AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: isActive ? AppColors.sakuraDeepPink : AppColors.textSecondary)),
      ],
    );
  }
}
