# 🌸 SakuraDrill

**SakuraDrill** is a gamified Japanese learning application designed with a production-grade architecture. Its core philosophy is: *"Learn Japanese one petal at a time."*

## 🏗 Technical Architecture

The project strictly follows **Clean Architecture** principles, ensuring separation of concerns, testability, and scalability.

- **Presentation Layer:** Managed using **BLoC** (Business Logic Component) for reactive state management.
- **Domain Layer:** Pure Dart entities, repository interfaces, and use cases. Includes a specialized **SRS Engine**.
- **Data Layer:** Repository implementations, data sources (Remote: Firebase, Local: Hive), and models.

## 🚀 Tech Stack & Libraries

- **Framework:** Flutter (Latest Stable)
- **State Management:** `flutter_bloc`
- **Dependency Injection:** `get_it` & `injectable` (Code generation)
- **Navigation:** `go_router`
- **Data Modeling:** `freezed` & `json_serializable`
- **Local Database:** `hive_flutter` (Offline-first approach)
- **Authentication:** `firebase_auth`
- **Functional Programming:** `fpdart` (for `Either<Failure, Success>`)
- **UI & Styling:** Google Fonts (Noto Sans), custom Sakura Pink design system.

## 🧠 Core Features

1.  **SRS Engine (Spaced Repetition System):** A custom algorithm written in pure Dart to handle learning steps (AGAIN, HARD, GOOD, EASY) and optimize memory retention.
2.  **Gamified Learning:** XP system, daily goals, and streaks to keep users engaged.
3.  **Authentication:** Secure login and registration via Firebase, with persistent login state.
4.  **Offline-First:** All study progress and flashcards are stored locally using Hive for a seamless experience.

## 🧱 Folder Structure

```text
lib/
  ├── core/          # Error handling, theme, constants, network info, router
  ├── shared/        # Reusable UI widgets and formatters
  ├── features/      # Feature slices: auth/, home/, study/, profile/, settings/, srs/
  │    ├── data/         # Models, Data Sources, Repositories Impl
  │    ├── domain/       # Entities, Repositories Interfaces, UseCases, Logic
  │    └── presentation/ # BLoC, Screens, Widgets
  └── injection.dart # Dependency Injection setup
```

## 🛠 Getting Started

### Prerequisites
- Flutter SDK (latest)
- Dart SDK
- [FVM](https://fvm.app/) (Optional, project uses FVM)

### Installation
1.  Clone the repository.
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Run code generation:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
4.  Run the application:
    ```bash
    flutter run
    ```

## 🧪 Testing
Unit tests for the SRS Engine logic can be found in `test/features/study/domain/logic/srs_engine_test.dart`.
Run tests using:
```bash
flutter test
```
