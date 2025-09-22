# Error handling rules for `lib/features/tests`

This document describes how errors and failures are handled in the `lib/features/tests` feature.

- **Layered error mapping**: Exceptions thrown by lower-level code (network, local cache, auth, etc.) are caught and mapped to `Failure` objects via the `toFailure` extension defined in `lib/core/resources/errors/exceptions_mapper.dart`.
  - The `toFailure` extension maps known exceptions to concrete `Failure` subclasses such as `ServerFailure`, `TimeOutFailure`, `AuthFailure`, `FileNotExistsFailure`, `ItemNotExistsFailure`, `CacheFailure`, and falls back to `UnknownFailure` for unknown exceptions.

- **Repository contract**: Repositories in `lib/features/tests/data/repositories` return `Either<Failure, Response>` from their methods (using `dartz`). On success they return `Right(response)`. On error they `catch (Exception e)` and return `Left(e.toFailure)` (or a specific `Failure` in rare cases).
  - Example: `ResultsRepositoryImpl.addResult` uses `try { ... } on Exception catch (e) { return Left(e.toFailure); }`.
  - Note: There are a few places where a repository may return a manual `UnknownFailure` with a custom message (see `getResult` in `results_repository_impl.dart`).

- **Remote data sources**: Remote data sources (e.g. `tests_remote_data_source_impl.dart`, `results_remote_data_source_impl.dart`) call the API layer (`ApiManager`) and parse responses into response models. They do not themselves map exceptions to `Failure`; that mapping happens at repository level via `exceptions_mapper`.

- **Usecases and BLoCs**: Usecases return `Either<Failure, Response>` from repository calls. BLoCs or higher-level callers call usecases and handle the `Either` result by folding:
  - On `Left(failure)`: emit a failure state or show a `FailureWidget` which renders `failure.message`.
  - On `Right(response)`: proceed with success flow.

- **UI representation**: The UI expects a `Failure` object and uses its `message` property to show human-friendly error text. For generic error screens/widgets, `UnknownFailure` is used as a fallback.

- **Best practices to follow**:
  - Always throw specific exceptions at the lowest layer (e.g., wrap Dio errors into `DioException` or `ServerException`), so `toFailure` can map them cleanly.
  - Repositories should `catch (Exception e)` and return `Left(e.toFailure)` unless there is a reason to return a custom `Failure` with a specific message.
  - Avoid catching `Error` or `Throwable`-like types; only catch `Exception` where intended.
  - Keep UI logic minimal: handle `Failure` instances by reading `failure.message` and showing retry options when applicable (e.g., `FailureWidget`).

- **Files referenced**:
  - `lib/core/resources/errors/exceptions_mapper.dart` — mapping from exceptions to `Failure`.
  - `lib/core/resources/errors/failures.dart` — failure types and default messages.
  - `lib/features/tests/data/repositories/tests_repository_impl.dart` and `results_repository_impl.dart` — repository usage pattern.
  - `lib/features/tests/data/datasources/tests_remote_data_source_impl.dart` and `results_remote_data_source_impl.dart` — remote calls and parsing.
  - `lib/core/widgets/ui/retry_widget.dart` (FailureWidget) — example of UI rendering a `Failure`.

This document should be kept updated if new failure types or exception mappings are added.
