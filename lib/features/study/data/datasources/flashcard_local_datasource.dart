import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/flashcard_model.dart';

abstract class FlashcardLocalDataSource {
  Future<List<FlashcardModel>> getFlashcards();
  Future<void> saveFlashcard(FlashcardModel card);
  Future<void> deleteFlashcard(String id);
}

@LazySingleton(as: FlashcardLocalDataSource)
class FlashcardLocalDataSourceImpl implements FlashcardLocalDataSource {
  static const String boxName = 'flashcards_box';

  @override
  Future<List<FlashcardModel>> getFlashcards() async {
    final box = await Hive.openBox<FlashcardModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> saveFlashcard(FlashcardModel card) async {
    final box = await Hive.openBox<FlashcardModel>(boxName);
    await box.put(card.id, card);
  }

  @override
  Future<void> deleteFlashcard(String id) async {
    final box = await Hive.openBox<FlashcardModel>(boxName);
    await box.delete(id);
  }
}
