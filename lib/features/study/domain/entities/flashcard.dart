import 'package:equatable/equatable.dart';
import 'srs_types.dart';

class Flashcard extends Equatable {
  final String id;
  final String front;
  final String back;
  final CardState state;
  final Duration interval; // Dalam detik/menit/hari
  final DateTime lastReview;
  final DateTime nextReview;

  const Flashcard({
    required this.id,
    required this.front,
    required this.back,
    this.state = CardState.newCard,
    this.interval = Duration.zero,
    required this.lastReview,
    required this.nextReview,
  });

  Flashcard copyWith({
    CardState? state,
    Duration? interval,
    DateTime? lastReview,
    DateTime? nextReview,
  }) {
    return Flashcard(
      id: id,
      front: front,
      back: back,
      state: state ?? this.state,
      interval: interval ?? this.interval,
      lastReview: lastReview ?? this.lastReview,
      nextReview: nextReview ?? this.nextReview,
    );
  }

  @override
  List<Object?> get props => [id, state, interval, lastReview, nextReview];
}
