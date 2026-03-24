import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/flashcard.dart';

abstract class FlashcardRepository {
  Future<Either<Failure, List<Flashcard>>> getFlashcards();
  Future<Either<Failure, Unit>> saveFlashcard(Flashcard card);
  Future<Either<Failure, Unit>> deleteFlashcard(String id);
}
