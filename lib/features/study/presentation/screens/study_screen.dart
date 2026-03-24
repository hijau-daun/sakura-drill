import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/entities/srs_types.dart';

class StudyScreen extends StatefulWidget {
  final Flashcard card;
  final Function(ReviewResult) onResult;

  const StudyScreen({
    super.key,
    required this.card,
    required this.onResult,
  });

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textMain),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Study', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.sakuraPink.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
                SizedBox(width: 4),
                Text('12', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textMain)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=fajar')),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Segmented Progress Bar
            Row(
              children: List.generate(5, (index) {
                return Expanded(
                  child: Container(
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index < 3 ? const Color(0xFFA68D92) : AppColors.divider,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
            ),
            
            const Spacer(),
            
            // Card Content
            Center(
              child: Column(
                children: [
                  Text(
                    widget.card.front,
                    style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: AppColors.textMain),
                  ),
                  const SizedBox(height: 40),
                  
                  if (_isFlipped) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.divider.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('NEKO', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.card.back,
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.textMain),
                    ),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '"The common domestic cat, a small carnivorous mammal."',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: AppColors.textSecondary),
                      ),
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: () => setState(() => _isFlipped = true),
                      child: const Text(
                        'Tap to reveal meaning',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            const Spacer(),
            
            // SRS Action Buttons
            if (_isFlipped) 
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _srsButton('AGAIN', Icons.history, AppColors.srsAgain, AppColors.srsAgainText, ReviewResult.again),
                    _srsButton('HARD', Icons.fitness_center, AppColors.srsHard, AppColors.srsHardText, ReviewResult.hard),
                    _srsButton('GOOD', Icons.sentiment_satisfied_alt, AppColors.srsGood, AppColors.srsGoodText, ReviewResult.good, badge: '+10'),
                    _srsButton('EASY', Icons.bolt, AppColors.srsEasy, AppColors.srsEasyText, ReviewResult.easy),
                  ],
                ),
              )
            else
              const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _srsButton(String label, IconData icon, Color bgColor, Color textColor, ReviewResult result, {String? badge}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: () => widget.onResult(result),
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: result == ReviewResult.good ? Border.all(color: textColor, width: 2) : null,
                ),
                child: Icon(icon, color: textColor, size: 32),
              ),
            ),
            if (badge != null)
              Positioned(
                top: -10,
                right: -10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C7B52),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
      ],
    );
  }
}
