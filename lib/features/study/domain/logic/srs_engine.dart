import '../entities/flashcard.dart';
import '../entities/srs_types.dart';

class SRSEngine {
  static Flashcard processReview(Flashcard card, ReviewResult result, DateTime now) {
    CardState newState;
    Duration newInterval;

    switch (result) {
      case ReviewResult.again:
        newState = CardState.learning;
        newInterval = const Duration(minutes: 10);
        break;
      case ReviewResult.hard:
        newState = CardState.review;
        newInterval = const Duration(days: 1);
        break;
      case ReviewResult.good:
        newState = CardState.review;
        // Interval calculation: 
        // If it's a new or learning card, start with 1 day
        // Otherwise, multiply current interval by 2
        if (card.state == CardState.newCard || card.state == CardState.learning) {
          newInterval = const Duration(days: 1);
        } else {
          newInterval = Duration(seconds: (card.interval.inSeconds * 2));
        }
        break;
      case ReviewResult.easy:
        newState = CardState.mastered;
        // Interval calculation:
        // If it's a new or learning card, start with 4 days
        // Otherwise, multiply current interval by 2.5
        if (card.state == CardState.newCard || card.state == CardState.learning) {
          newInterval = const Duration(days: 4);
        } else {
          newInterval = Duration(seconds: (card.interval.inSeconds * 2.5).round());
        }
        break;
    }

    return card.copyWith(
      state: newState,
      interval: newInterval,
      lastReview: now,
      nextReview: now.add(newInterval),
    );
  }
}
