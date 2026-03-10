# Implementation Plan: JSON Serializable Architecture Optimization

## Context & Goals
The goal of this refactor is to optimize the `json_serializable` mapping layer to be as concise as possible while maintaining strict Clean Architecture principles. Currently, many models contain redundant `@JsonKey(name: 'snake_case')` annotations and manual type-conversion hacks that exist to bridge mismatches between the Supabase database and the Dart application.

By adopting **`fieldRename: FieldRename.snake`** globally and aligning a few minor data types, we can delete approximately 50+ lines of repetitive code and make the models much easier to maintain.

### Golden Rule for `@JsonKey`
> **Any time `@JsonKey` cannot be removed (e.g. for enum converters, nested list converters, or a field name that does not follow standard snake_case), a comment MUST be added explaining why it is kept.**

Example:
```dart
// Kept: DB field 'is_test_mode' stores a bool but our domain uses a ResultTestMode enum.
@JsonKey(name: 'is_test_mode', fromJson: _resultTestModeFromJson, toJson: _resultTestModeToJson)
final ResultTestMode? resultTestMode;
```

---

## 1. Database Alignment Tasks (Pre-requisites)
Ensure the following constraints are met in Supabase before executing the Flutter changes:

- **Table `question_options`, Column `id`**: Must be `NOT NULL`.
  - *Rationale:* Removes the Flutter-side `_idFromJson` fallback that generates a timestamp ID.
- **Table `version`, Column `id`**: Must provide an integer.
  - *Rationale:* We are changing the Dart type from `String` to `int` to match the native DB structure.

---

## 2. Database Schema → Dart Type Reference

This table is derived from the SQL table definitions and is the source of truth for nullability and Dart types.

| Table | Column | SQL Type | Nullable? | Dart Type |
|---|---|---|---|---|
| `sections` | `id` | INTEGER | NOT NULL | `int` |
| `sections` | `title` | TEXT | NOT NULL | `String` |
| `governorates` | `id` | INTEGER | NOT NULL | `int` |
| `governorates` | `title` | TEXT | NOT NULL | `String` |
| `units` | `id` | INTEGER | NOT NULL | `int` |
| `units` | `title` | TEXT | NOT NULL | `String` |
| `units` | `subtitle` | TEXT | NOT NULL | `String` |
| `units` | `icon_url` | TEXT | **NULL** | `String?` |
| `units` | `sort_order` | INTEGER | **NULL** (DEFAULT 0) | `int?` |
| `units` | `created_at` | TIMESTAMPTZ | **NULL** (DEFAULT) | `DateTime?` |
| `units` | `updated_at` | TIMESTAMPTZ | **NULL** (DEFAULT) | `DateTime?` |
| `lessons` | `id` | INTEGER | NOT NULL | `int` |
| `lessons` | `title` | TEXT | NOT NULL | `String` |
| `lessons` | `unit_id` | INTEGER | NOT NULL | `int` |
| `lessons` | `icon_url` | TEXT | **NULL** | `String?` |
| `lessons` | `sort_order` | INTEGER | **NULL** (DEFAULT 0) | `int?` |
| `question_categories` | `id` | INTEGER | NOT NULL | `int` |
| `question_categories` | `title` | TEXT | NOT NULL | `String` |
| `question_categories` | `sort_order` | INTEGER | **NULL** (DEFAULT 0) | `int?` |
| `question_categories` | `is_orderable` | BOOLEAN | NOT NULL | `bool` |
| `question_categories` | `is_typeable` | BOOLEAN | NOT NULL | `bool` |
| `question_categories` | `is_mcq` | BOOLEAN | NOT NULL | `bool` |
| `question_categories` | `is_single_answer` | BOOLEAN | NOT NULL | `bool` |
| `questions` | `id` | INTEGER | NOT NULL | `int` |
| `questions` | `content` | TEXT | NOT NULL | `String` |
| `questions` | `image_url` | TEXT | **NULL** | `String?` |
| `questions` | `lesson_id` | INTEGER | NOT NULL | `int` |
| `questions` | `category_id` | INTEGER | NOT NULL | `int` |
| `question_options` | `id` | INTEGER | NOT NULL (after DB fix) | `int` |
| `question_options` | `content` | TEXT | NOT NULL | `String` |
| `question_options` | `is_correct` | BOOLEAN | **NULL** (DEFAULT false) | `bool?` |
| `question_options` | `sort_order` | INTEGER | **NULL** | `int?` |
| `question_options` | `question_id` | INTEGER | NOT NULL | `int` |
| `question_options` | `image_url` | TEXT | **NULL** | `String?` |
| `question_answers` | `id` | BIGINT | NOT NULL | `int` |
| `question_answers` | `result_id` | BIGINT | NOT NULL | `int` |
| `question_answers` | `question_id` | INTEGER | NOT NULL | `int` |
| `question_answers` | `option_id` | INTEGER | **NULL** | `int?` |
| `question_answers` | `answer_text` | TEXT | **NULL** | `String?` |
| `question_answers` | `answer_position` | INTEGER | **NULL** | `int?` |
| `question_answers` | `is_correct` | BOOL | NOT NULL (DEFAULT false) | `bool` |
| `answer_evaluations` | `id` | BIGINT | NOT NULL | `int` |
| `answer_evaluations` | `question_answer_id` | BIGINT | NOT NULL | `int` |
| `answer_evaluations` | `is_correct` | BOOLEAN | NOT NULL | `bool` |
| `answer_evaluations` | `confidence` | NUMERIC(5,2) | **NULL** | `double?` |
| `answer_evaluations` | `notes` | TEXT | **NULL** | `String?` |
| `answer_evaluations` | `model_name` | TEXT | **NULL** | `String?` |
| `answer_evaluations` | `created_at` | TIMESTAMPTZ | **NULL** (DEFAULT) | `DateTime?` |
| `answer_evaluations` | `updated_at` | TIMESTAMPTZ | **NULL** (DEFAULT) | `DateTime?` |
| `results` | `id` | BIGINT | NOT NULL | `int` |
| `results` | `user_id` | UUID | NOT NULL | `String` |
| `results` | `lesson_id` | INTEGER | **NULL** | `int?` |
| `results` | `total_questions` | INTEGER | NOT NULL | `int` |
| `results` | `correct_answers` | INTEGER | NOT NULL | `int` |
| `results` | `wrong_answers` | INTEGER | NOT NULL | `int` |
| `results` | `score` | NUMERIC(5,2) | NOT NULL | `double` |
| `results` | `duration_seconds` | INTEGER | NOT NULL | `int` |
| `results` | `is_test_mode` | BOOLEAN | NOT NULL (DEFAULT false) | `bool` → mapped to `ResultTestMode?` enum |
| `results` | `created_at` | TIMESTAMPTZ | **NULL** (DEFAULT) | `DateTime` |
| `results` | `updated_at` | TIMESTAMPTZ | **NULL** (DEFAULT) | `DateTime` |
| `notification_topics` | `id` | BIGSERIAL | NOT NULL | `int` |
| `notification_topics` | `title` | VARCHAR(50) | NOT NULL | `String` |
| `notification_topics` | `description` | TEXT | **NULL** | `String?` |
| `notification_topics` | `firebase_topic` | VARCHAR(50) | **NULL** (UNIQUE) | `String` (treated as required in entity) |
| `notification_topics` | `subscribable` | BOOLEAN | NOT NULL (DEFAULT TRUE) | `bool` |
| `notifications` | `id` | BIGSERIAL | NOT NULL | `int` |
| `notifications` | `topic_id` | BIGINT | **NULL** | `int` (entity has it non-null) |
| `notifications` | `title` | TEXT | NOT NULL | `String` |
| `notifications` | `body` | TEXT | NOT NULL | `String` |
| `notifications` | `image_url` | TEXT | **NULL** | `String?` |
| `notifications` | `payload` | JSONB | **NULL** | `Map<String,dynamic>?` |
| `notifications` | `priority` | ENUM | **NULL** (DEFAULT 'normal') | `NotificationPriority` |
| `notifications` | `created_at` | TIMESTAMPTZ | **NULL** (DEFAULT) | `DateTime` |
| `notifications` | `expires_at` | TIMESTAMPTZ | **NULL** | `DateTime?` |
| `user_topic_subscriptions` | `user_id` | UUID | NOT NULL | `String` |
| `user_topic_subscriptions` | `topic_id` | BIGINT | NOT NULL | `int` |
| `user_notifications` | `id` | BIGSERIAL | NOT NULL | `int` |
| `user_notifications` | `user_id` | UUID | NOT NULL | `String` |
| `user_notifications` | `notification_id` | BIGINT | NOT NULL | `int` |
| `user_notifications` | `read_at` | TIMESTAMPTZ | **NULL** | `DateTime?` |
| `user_device_tokens` | `id` | BIGSERIAL | NOT NULL | `int` |
| `user_device_tokens` | `user_id` | UUID | NOT NULL | `String` |
| `user_device_tokens` | `device_brand` | TEXT | NOT NULL | `String` |
| `user_device_tokens` | `device_model` | TEXT | NOT NULL | `String` |
| `user_device_tokens` | `device_token` | TEXT | NOT NULL | `String` |
| `user_device_tokens` | `updated_at` | TIMESTAMPTZ | NOT NULL (DEFAULT) | `DateTime` |
| `exception_reports` | `id` | BIGINT | NOT NULL | `int` |
| `exception_reports` | `exception_type` | TEXT | NOT NULL | `String` |
| `exception_reports` | `message` | TEXT | NOT NULL | `String` |
| `exception_reports` | `stack_trace` | TEXT | **NULL** | `String?` |
| `exception_reports` | `trigger` | TEXT | **NULL** | `String?` |
| `exception_reports` | `app_version` | TEXT | **NULL** | `String?` |
| `exception_reports` | `platform` | TEXT | **NULL** | `String?` |
| `exception_reports` | `device_model` | TEXT | **NULL** | `String?` |
| `exception_reports` | `user_id` | UUID | **NULL** | `String?` |
| `exception_reports` | `created_at` | TIMESTAMPTZ | NOT NULL (DEFAULT) | `DateTime` |
| `motivational_quotes` | `id` | BIGSERIAL | NOT NULL | `int` |
| `motivational_quotes` | `quote` | TEXT | NOT NULL | `String` |
| `motivational_quotes` | `author` | VARCHAR(255) | NOT NULL | `String` |

> **Note on `version` table:** The table does not have its own SQL file in `database/tables/`; it is managed separately. The plan changes its `id` from `String` to `int` (Phase A below).

---

## 3. All Detected Entities & Models Using JSON Serializable

### Entities (Domain Layer — No JSON annotations, but affected by type alignment)

| Entity File | Affected Fields |
|---|---|
| `lib/features/tests/domain/entities/question_category.dart` | `questionsCount`: currently `int?` — DB has no column for this; it is a computed join field, so nullable is correct |
| `lib/features/tests/domain/entities/unit.dart` | `icon`: currently `String?` — DB: `icon_url TEXT NULL` ✅ |
| `lib/features/tests/domain/entities/lesson.dart` | All fields match DB ✅ |
| `lib/features/tests/domain/entities/option.dart` | `isCorrect`: entity has `bool?`, DB has `BOOLEAN NULL DEFAULT false` ✅ |
| `lib/features/tests/domain/entities/question.dart` | `imageUrl`: `String?` ✅; `categoryId`: `int?` but DB has NOT NULL — **consider making non-nullable** |
| `lib/features/tests/domain/entities/question_answer.dart` | `isCorrect`: entity has `bool?` but DB has `NOT NULL DEFAULT false` — **should be `bool`** |
| `lib/features/tests/domain/entities/test_options.dart` | Not DB-mapped (local/SharedPreferences model) ✅ |
| `lib/features/results/domain/entities/result.dart` | `lessonId`: `int?` ✅; `lessonTitle`, `resultOrder`: computed join fields, nullable OK |
| `lib/features/results/domain/entities/result_answer.dart` | `optionId`: `int?` ✅ |
| `lib/features/results/domain/entities/answer_evaluation.dart` | `confidence`: `double?` ✅; `createdAt`/`updatedAt`: entity has `DateTime?` — DB has DEFAULT NOW(), always set, **should be `DateTime` non-null** |
| `lib/features/notifications/domain/entities/notification.dart` | `topic_id`: DB is nullable but entity has `int` (non-null) — **consider making `int?`** |
| `lib/features/notifications/domain/entities/notifications_topic.dart` | All fields match DB ✅ |
| `lib/features/notifications/domain/entities/user_notification.dart` | `deliveredAt`, `dismissedAt`, `actionPerformed`: **DB has no such columns** — these are app-side computed fields |
| `lib/features/notifications/domain/entities/user_topic_subscription.dart` | All fields match DB ✅ |
| `lib/features/notifications/domain/entities/app_notification.dart` | Same as `Notification` entity + `readedAt` (app-side) |
| `lib/features/auth/domain/entites/user_data.dart` | `sectionId`, `governorateId`: currently `String` — DB stores as INTEGER, manual `.toString()` cast in model. **Consider changing to `int`** |
| `lib/features/settings/domain/entities/version.dart` | `id`: currently `String` — **Phase A: change to `int`** |
| `lib/features/settings/domain/entities/motivational_quote.dart` | `date`: not a DB column (mapped from `created_at`) — custom converter ✅ |
| `lib/features/reports/domain/entities/exception_report.dart` | All fields match DB ✅ |

### Models (Data Layer — All use `@JsonSerializable`)

| Model File | Current Annotation | Changes Needed |
|---|---|---|
| `lib/features/tests/data/models/question_category_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 5 `@JsonKey(name:...)` |
| `lib/features/tests/data/models/unit_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove `@JsonKey(name:...)` for `lessonsCount`, `iconUrl`, `createdAt`, `updatedAt`; rename field `icon` → `iconUrl` to match DB |
| `lib/features/tests/data/models/lesson_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 2 `@JsonKey(name:...)` |
| `lib/features/tests/data/models/option_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove `_idFromJson` function and its `@JsonKey`; remove 3 `@JsonKey(name:...)` |
| `lib/features/tests/data/models/question_model.dart` | `@JsonSerializable(explicitToJson: true)` | Add `fieldRename: FieldRename.snake`; remove 4 `@JsonKey(name:...)` from constructor; keep and annotate all `fromJson`/`toJson` converters for nested lists |
| `lib/features/tests/data/models/question_answer_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 5 `@JsonKey(name:...)` |
| `lib/features/tests/data/models/test_options_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 5 `@JsonKey(name:...)` from constructor; keep enum and list converters with explanatory comments |
| `lib/features/results/data/models/result_model.dart` | `@JsonSerializable(explicitToJson: true)` | Add `fieldRename: FieldRename.snake`; remove 8 `@JsonKey(name:...)` from constructor; keep `is_test_mode` and `question_answers` converters with comments |
| `lib/features/results/data/models/result_answer_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 3 `@JsonKey(name:...)` |
| `lib/features/results/data/models/answer_evaluation_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 5 `@JsonKey(name:...)` |
| `lib/features/notifications/data/models/notification_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 5 `@JsonKey(name:...)` from constructor; keep enum converter with comment |
| `lib/features/notifications/data/models/notification_topic_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove `@JsonKey(name: 'firebase_topic')` |
| `lib/features/notifications/data/models/user_notification_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 5 `@JsonKey(name:...)` |
| `lib/features/notifications/data/models/device_token_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 3 `@JsonKey(name:...)` |
| `lib/features/notifications/data/models/app_notification_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 5 `@JsonKey(name:...)` from constructor; keep enum converter with comment |
| `lib/features/notifications/data/models/user_topic_subscription_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 2 `@JsonKey(name:...)` |
| `lib/features/notifications/data/models/notification_action_model.dart` | `@JsonSerializable()` | No `@JsonKey(name:...)` to remove; keep enum converter with comment |
| `lib/features/auth/data/models/user_data_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 2 `@JsonKey(name:...)` for `governorateId`, `sectionId`; remove manual `.toString()` cast in `fromJson` (after type alignment — see Phase D) |
| `lib/features/auth/data/models/section_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; no `@JsonKey(name:...)` present — annotation change only |
| `lib/features/auth/data/models/governorate_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; no `@JsonKey(name:...)` present — annotation change only |
| `lib/features/settings/data/models/version_model.dart` | `@JsonSerializable(fieldRename: FieldRename.snake)` | Already has `fieldRename`; remove `_toString` converter for `id` after changing to `int` (Phase A); keep `_buildNumberFromJson` with comment |
| `lib/features/settings/data/models/motivational_quote_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; keep `_dateFromJson` converter with comment (DB uses `created_at`, mapped to `date`) |
| `lib/features/settings/data/models/app_settings_model.dart` | `@JsonSerializable(explicitToJson: true)` | Add `fieldRename: FieldRename.snake`; no `@JsonKey(name:...)` on constructor fields to remove (all use custom converters); keep all nested converters with comments |
| `lib/features/reports/data/models/exception_report_model.dart` | `@JsonSerializable()` | Add `fieldRename: FieldRename.snake`; remove 7 `@JsonKey(name:...)` |

---

## 4. Implementation Phases

### Phase A: Type Alignment — `Version.id`: `String` → `int`
- **Entity**: `lib/features/settings/domain/entities/version.dart`
  - Change `final String id` → `final int id`
  - Update default value from `id = "0"` → `id = 0`
  - Update `Version.empty()` factory
- **Model**: `lib/features/settings/data/models/version_model.dart`
  - Remove `@JsonKey(fromJson: _toString)` from `id`
  - Delete the `static String _toString(dynamic value)` function

### Phase B: Remove ID Fallback — `OptionModel`
> Depends on the DB fix: `question_options.id` set to `NOT NULL`.
- **Model**: `lib/features/tests/data/models/option_model.dart`
  - Remove `@JsonKey(fromJson: _idFromJson)` from `id` parameter
  - Delete the `static int _idFromJson(int? id)` function

### Phase C: Type Alignment — `QuestionAnswer.isCorrect`: `bool?` → `bool`
The DB column `is_correct BOOL NOT NULL DEFAULT false` is always present.
- **Entity**: `lib/features/tests/domain/entities/question_answer.dart`
  - Change `final bool? isCorrect` → `final bool isCorrect`
  - Update constructor default value to `this.isCorrect = false`
  - Update `copyWith` signature
- **Model**: `lib/features/tests/data/models/question_answer_model.dart`
  - Update `super.isCorrect` parameter accordingly

### Phase D: Type Alignment — `UserData.sectionId`/`governorateId`: `String` → `int`
> **Decision required**: The entity currently stores these as `String`, which requires a manual cast in the model. Changing to `int` unifies DB → Dart without any conversion. However, this is a breaking change if these values are used as strings elsewhere.
> If you proceed:
- **Entity**: `lib/features/auth/domain/entites/user_data.dart`
  - Change `final String sectionId` → `final int sectionId`
  - Change `final String governorateId` → `final int governorateId`
- **Model**: `lib/features/auth/data/models/user_data_model.dart`
  - Remove the manual `fromJson` cast block (the three `if (json[...] != null)` lines)
  - Remove `@JsonKey(name: 'governorate_id')` and `@JsonKey(name: 'section_id')` after adding `fieldRename`

### Phase E: Global `FieldRename.snake` Refactor (All Models)
For every model in the table above (Section 3), apply:
1. Change `@JsonSerializable()` → `@JsonSerializable(fieldRename: FieldRename.snake)`.
2. Delete every `@JsonKey(name: 'snake_case_name')` where the name is the simple snake_case version of the Dart field.
3. **Keep** any `@JsonKey` that has:
   - `fromJson`/`toJson` (type conversion or enum mapping)
   - `defaultValue`
   - `includeFromJson`/`includeToJson`
   - A `name` that does NOT match the expected snake_case (e.g., `lessonTitle` comes from `lesson_title` which IS standard, so remove it; but `resultOrder` comes from DB field `user_rank`, so the `name: 'user_rank'` MUST stay with a comment).
4. Add an explanatory comment above every remaining `@JsonKey`.

#### Special Cases (Fields where `@JsonKey(name:...)` MUST be kept with a comment):

| Model | Field | DB Column | Reason |
|---|---|---|---|
| `result_model.dart` | `resultOrder` | `user_rank` | DB column name `user_rank` does not match Dart field `result_order` |
| `result_model.dart` | `lessonTitle` | `lesson_title` | Computed join field, not a real column — `field_rename` would produce `lesson_title` which is correct, so actually CAN remove |
| `result_model.dart` | `resultTestMode` (mapped from `is_test_mode`) | `is_test_mode` | Field rename would produce `result_test_mode`, not `is_test_mode` — MUST keep `name: 'is_test_mode'` |
| `unit_model.dart` | `icon` | `icon_url` | Entity field is named `icon` but DB column is `icon_url` — MUST keep `name:'icon_url'` OR rename entity field to `iconUrl` |
| `motivational_quote_model.dart` | `date` | `created_at` | Entity field named `date`, DB column is `created_at` — MUST keep `name: 'created_at'` |

---

## 5. Verification

### Step 1: Regenerate Code
```bash
dart run build_runner build --delete-conflicting-outputs
```
This must complete with **zero errors**.

### Step 2: Run Unit Tests
```bash
flutter test test/features/results/
flutter test test/features/tests/
```

### Step 3: Full Test Suite
```bash
flutter test
```
All tests must pass before the refactor is considered complete.
