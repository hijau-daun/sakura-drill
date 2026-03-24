import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../datasources/flashcard_local_datasource.dart';
import '../models/flashcard_model.dart';

@LazySingleton(as: FlashcardRepository)
class FlashcardRepositoryImpl implements FlashcardRepository {
  final FlashcardLocalDataSource localDataSource;

  FlashcardRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Flashcard>>> getFlashcards() async {
    try {
      final models = await localDataSource.getFlashcards();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveFlashcard(Flashcard card) async {
    try {
      final model = FlashcardModel.fromEntity(card);
      await localDataSource.saveFlashcard(model);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFlashcard(String id) async {
    try {
      await localDataSource.deleteFlashcard(id);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
