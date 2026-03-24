# 🌸 SakuraDrill - AI Agent Prompt (Stage 2: Data Layer & Seeding)

**System Role:** You are an elite Flutter Senior Engineer and Software Architect specializing in Clean Architecture, BLoC, and Test-Driven Development (TDD).

**Context:** We are continuing the development of "SakuraDrill". In this stage, we are focusing on the Data Layer, specifically how we structure the flashcard data and how we populate the offline-first local database using a pre-bundled JSON approach (Data Seeding).

---

## ⚠️ Execution Rules (CRITICAL)

1. Provide the complete file path at the top of the code block (e.g., `// lib/features/study/data/models/flashcard_model.dart`).
2. Do not use placeholders like `// implementation goes here`. Write the actual, complete production code.
3. Strictly follow Clean Architecture dependency rules (Presentation -> Domain <- Data).
4. Use `freezed` and `json_serializable` for all models.
5. Use `fpdart` for error handling (`Either<Failure, Success>`).

---

## 🎯 Stage 2 Objectives

Your task is to implement the following components:

### 1. Pre-bundled JSON Data (The Seed)
Create a dummy JSON file representing Level 1 (JLPT N5) vocabulary.
- **Path:** `assets/data/n5_level_1.json` (Make sure to remind me to add this to `pubspec.yaml`).
- **Structure:** Array of objects containing `id`, `kanji`, `kana`, `romaji`, `meaning`, and `level`. Include at least 5 dummy words.

### 2. Domain Entities
Define the core Entities in the Domain layer for the Flashcard.
- **Entity:** `Flashcard` (id, kanji, kana, romaji, meaning, level).
- **Entity:** `UserCardData` (id, flashcardId, srsState, nextReviewDate, easeFactor, interval). *Note: `srsState` enum should be NEW, LEARNING, REVIEW, MASTERED.*

### 3. Data Models
Create the Data Models that implement the Domain Entities using `freezed`.
- `FlashcardModel` (with `fromJson` and `toJson`).
- `UserCardDataModel`.

### 4. Local Database Setup (Hive)
Set up Hive for local storage. 
- Create TypeAdapters for the models if necessary.
- Initialize Hive boxes: `flashcards_box` (for static dictionary data) and `user_progress_box` (for SRS tracking).

### 5. Data Seeder Service (The Engine)
Create a robust service class that runs on app initialization (First Launch).
- **Name:** `DatabaseSeeder` or `DataInitializationService`.
- **Logic:**
  1. Check if the database has already been seeded (e.g., check a boolean in `SharedPreferences` or if `flashcards_box` is empty).
  2. If empty, read the `assets/data/n5_level_1.json` file.
  3. Parse the JSON and insert the records into the Hive `flashcards_box`.
  4. Create initial `UserCardData` (state = NEW) for these cards in `user_progress_box`.
  5. Mark initialization as complete.

### 6. Repository Interface & Implementation
- **Domain:** `IFlashcardRepository` (methods: `initData()`, `getCardsByLevel(int level)`, `updateCardProgress(UserCardData data)`).
- **Data:** `FlashcardRepositoryImpl` (implements the interface using Hive and the Seeder).

---

## 🚀 Action Required Now

Please output the complete code for the objectives above, file by file. Start with the JSON asset, then Entities, Models, Database Setup, Seeder Service, and finally the Repository. Include necessary `freezed` setup instructions.
 
