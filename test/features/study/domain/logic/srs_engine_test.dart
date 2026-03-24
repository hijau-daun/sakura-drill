import 'package:flutter_test/flutter_test.dart';
import 'package:sakura_drill/features/study/domain/entities/flashcard.dart';
import 'package:sakura_drill/features/study/domain/entities/srs_types.dart';
import 'package:sakura_drill/features/study/domain/logic/srs_engine.dart';

void main() {
  group('SRSEngine Logic Tests', () {
    late Flashcard newCard;
    final now = DateTime(2026, 1, 1, 10, 0);

    setUp(() {
      newCard = Flashcard(
        id: '1',
        front: '桜',
        back: 'Sakura',
        lastReview: now,
        nextReview: now,
      );
    });

    test('AGAIN review should set state to LEARNING and interval to 10 mins', () {
      final updated = SRSEngine.processReview(newCard, ReviewResult.again, now);

      expect(updated.state, CardState.learning);
      expect(updated.interval, const Duration(minutes: 10));
      expect(updated.nextReview, now.add(const Duration(minutes: 10)));
    });

    test('HARD review should set state to REVIEW and interval to 1 day', () {
      final updated = SRSEngine.processReview(newCard, ReviewResult.hard, now);

      expect(updated.state, CardState.review);
      expect(updated.interval, const Duration(days: 1));
    });

    test('GOOD review on new card should set state to REVIEW and interval to 1 day', () {
      final updated = SRSEngine.processReview(newCard, ReviewResult.good, now);

      expect(updated.state, CardState.review);
      expect(updated.interval, const Duration(days: 1));
    });

    test('GOOD review on existing review card should double the interval', () {
      final reviewCard = newCard.copyWith(
        state: CardState.review,
        interval: const Duration(days: 2),
      );
      
      final updated = SRSEngine.processReview(reviewCard, ReviewResult.good, now);

      expect(updated.interval, const Duration(days: 4));
    });

    test('EASY review on new card should set state to MASTERED and interval to 4 days', () {
      final updated = SRSEngine.processReview(newCard, ReviewResult.easy, now);

      expect(updated.state, CardState.mastered);
      expect(updated.interval, const Duration(days: 4));
    });
    
    test('EASY review on review card should multiply interval by 2.5', () {
       final reviewCard = newCard.copyWith(
        state: CardState.review,
        interval: const Duration(days: 4),
      );
      
      final updated = SRSEngine.processReview(reviewCard, ReviewResult.easy, now);

      expect(updated.interval, const Duration(days: 10));
    });
  });
}
