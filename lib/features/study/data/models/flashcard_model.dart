import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/entities/srs_types.dart';

part 'flashcard_model.freezed.dart';
part 'flashcard_model.g.dart';

@freezed
@HiveType(typeId: 0)
class FlashcardModel with _$FlashcardModel {
  const FlashcardModel._();

  const factory FlashcardModel({
    @HiveField(0) required String id,
    @HiveField(1) required String front,
    @HiveField(2) required String back,
    @HiveField(3) @Default(CardState.newCard) CardState state,
    @HiveField(4) @Default(Duration.zero) Duration interval,
    @HiveField(5) required DateTime lastReview,
    @HiveField(6) required DateTime nextReview,
  }) = _FlashcardModel;

  factory FlashcardModel.fromJson(Map<String, dynamic> json) =>
      _$FlashcardModelFromJson(json);

  // Conversion to Domain Entity
  Flashcard toEntity() => Flashcard(
        id: id,
        front: front,
        back: back,
        state: state,
        interval: interval,
        lastReview: lastReview,
        nextReview: nextReview,
      );

  // Conversion from Domain Entity
  factory FlashcardModel.fromEntity(Flashcard entity) => FlashcardModel(
        id: entity.id,
        front: entity.front,
        back: entity.back,
        state: entity.state,
        interval: entity.interval,
        lastReview: entity.lastReview,
        nextReview: entity.nextReview,
      );
}

// Hive Adapter for CardState
@HiveType(typeId: 1)
enum CardStateAdapter {
  @HiveField(0)
  newCard,
  @HiveField(1)
  learning,
  @HiveField(2)
  review,
  @HiveField(3)
  mastered,
}
