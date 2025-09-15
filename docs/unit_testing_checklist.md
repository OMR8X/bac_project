# Unit Testing Checklist for BAC Project

This document lists all the important files that should have unit tests written for them. Focus on these files to achieve comprehensive unit test coverage for your Flutter application.

## 📋 Testing Priority

- 🔴 **High Priority** - Critical business logic, core functionality
- 🟡 **Medium Priority** - Important but not critical
- 🟢 **Low Priority** - Nice to have, can be done later

## 🗂️ Data Models (JSON Serialization/Deserialization)

### Auth Feature Models
- 🔴 `lib/features/auth/data/models/user_data_model.dart` - Core user data model
- 🟡 `lib/features/auth/data/models/section_model.dart` - Educational sections
- 🟡 `lib/features/auth/data/models/governorate_model.dart` - Location data

### Tests Feature Models  
- 🔴 `lib/features/tests/data/models/question_model.dart` - Quiz question structure
- 🔴 `lib/features/tests/data/models/option_model.dart` - Question options
- 🔴 `lib/features/tests/data/models/result_model.dart` - Test results
- 🔴 `lib/features/tests/data/models/result_answer_model.dart` - User answers
- 🟡 `lib/features/tests/data/models/unit_model.dart` - Course units
- 🟡 `lib/features/tests/data/models/lesson_model.dart` - Course lessons
- 🟡 `lib/features/tests/data/models/test_options_model.dart` - Test configuration
- 🟡 `lib/features/tests/data/models/question_category_model.dart` - Question categories
- 🟡 `lib/features/tests/data/models/user_answer_model.dart` - User input tracking

### Settings Feature Models
- 🟡 `lib/features/settings/data/models/app_settings_model.dart` - App configuration
- 🟡 `lib/features/settings/data/models/version_model.dart` - App version info
- 🟡 `lib/features/settings/data/models/motivational_quote_model.dart` - Quote data

### Notifications Feature Models
- 🟡 `lib/features/notifications/data/models/app_notification_model.dart` - Notification structure
- 🟡 `lib/features/notifications/data/models/device_token_model.dart` - FCM token management

### Presentation Models
- 🟢 `lib/presentation/result/models/custom_result_card_model.dart` - UI result display
- 🟢 `lib/presentation/home/models/custom_navigation_card_model.dart` - Navigation UI
- 🟢 `lib/presentation/home/models/custom_action_card_model.dart` - Action cards UI

## 🗺️ Data Mappers (Entity ↔ Model Conversion)

### Core Mappers
- 🔴 `lib/core/resources/errors/exceptions_mapper.dart` - Error handling conversion
- 🔴 `lib/features/auth/data/mappers/user_data_mapper.dart` - User data conversion

### Tests Feature Mappers
- 🔴 `lib/features/tests/data/mappers/question_mapper.dart` - Question entity mapping
- 🔴 `lib/features/tests/data/mappers/option_mapper.dart` - Option entity mapping
- 🔴 `lib/features/tests/data/mappers/result_mapper.dart` - Result entity mapping
- 🔴 `lib/features/tests/data/mappers/result_answer_mapper.dart` - Answer mapping
- 🟡 `lib/features/tests/data/mappers/unit_mapper.dart` - Unit entity mapping
- 🟡 `lib/features/tests/data/mappers/lesson_mapper.dart` - Lesson entity mapping
- 🟡 `lib/features/tests/data/mappers/question_category_mapper.dart` - Category mapping
- 🟡 `lib/features/tests/data/models/test_options_mapper.dart` - Test options mapping

### Settings & Notifications Mappers
- 🟡 `lib/features/settings/data/mappers/app_settings_mapper.dart` - Settings mapping
- 🟡 `lib/features/settings/data/mappers/motivational_quote_mapper.dart` - Quote mapping
- 🟡 `lib/features/notifications/data/mappers/app_notification_mapper.dart` - Notification mapping

## 🏗️ Use Cases (Business Logic)

### Auth Feature Use Cases
- 🔴 `lib/features/auth/domain/usecases/sign_in_usecase.dart` - User authentication
- 🔴 `lib/features/auth/domain/usecases/sign_up_usecase.dart` - User registration
- 🔴 `lib/features/auth/domain/usecases/get_user_data_usecase.dart` - User data retrieval
- 🟡 `lib/features/auth/domain/usecases/change_password_usecase.dart` - Password management
- 🟡 `lib/features/auth/domain/usecases/forget_password_usecase.dart` - Password reset
- 🟡 `lib/features/auth/domain/usecases/update_user_data_usecase.dart` - Profile updates
- 🟡 `lib/features/auth/domain/usecases/sign_out_usecase.dart` - User logout

### Tests Feature Use Cases
- 🔴 `lib/features/tests/domain/usecases/get_questions_use_case.dart` - Question fetching
- 🔴 `lib/features/tests/domain/usecases/add_result_use_case.dart` - Result submission
- 🔴 `lib/features/tests/domain/usecases/get_result_use_case.dart` - Result retrieval
- 🔴 `lib/features/tests/domain/usecases/get_my_results_use_case.dart` - User results
- 🟡 `lib/features/tests/domain/usecases/get_units_use_case.dart` - Units fetching
- 🟡 `lib/features/tests/domain/usecases/get_lessons_use_case.dart` - Lessons fetching
- 🟡 `lib/features/tests/domain/usecases/get_test_options_use_case.dart` - Test configuration

### Settings Feature Use Cases
- 🟡 `lib/features/settings/domain/usecases/get_app_settings_usecase.dart` - App settings

### Notifications Feature Use Cases
- 🟡 `lib/features/notifications/domain/usecases/display_notification_usecase.dart` - Show notifications
- 🟡 `lib/features/notifications/domain/usecases/get_notifications_usecase.dart` - Fetch notifications

## 🏛️ Repositories (Data Layer Orchestration)

### Auth Feature Repository
- 🔴 `lib/features/auth/data/repositories/auth_repository_implement.dart` - Authentication data flow

### Tests Feature Repositories
- 🔴 `lib/features/tests/data/repositories/tests_repository_impl.dart` - Test data management
- 🔴 `lib/features/tests/data/repositories/results_repository_impl.dart` - Results data management

### Settings Feature Repository
- 🟡 `lib/features/settings/data/repositories/settings_repository_impl.dart` - Settings data

### Notifications Feature Repository
- 🟡 `lib/features/notifications/data/repositories/notifications_repository_implements.dart` - Notifications data

## 🔌 Data Sources (External Data Access)

### Remote Data Sources
- 🔴 `lib/features/auth/data/datasources/auth_remote_data_source.dart` - Authentication API
- 🔴 `lib/features/tests/data/datasources/tests_remote_data_source_impl.dart` - Tests API
- 🔴 `lib/features/tests/data/datasources/results_remote_data_source_impl.dart` - Results API
- 🟡 `lib/features/settings/data/datasources/settings_remote_datasource_impl.dart` - Settings API
- 🟡 `lib/features/notifications/data/datasources/notifications_remote_datasource.dart` - Notifications API

### Local Data Sources
- 🔴 `lib/features/auth/data/datasources/auth_local_data_source.dart` - Local user data
- 🟡 `lib/features/notifications/data/datasources/notifications_database_datasource.dart` - Local notifications

## 🛠️ Core Services & Utilities

### Cache Management
- 🔴 `lib/core/services/cache/cache_manager.dart` - Cache operations
- 🔴 `lib/core/services/cache/cache_client.dart` - Hive client implementation

### Other Core Services
- 🟡 `lib/core/services/paths/app_paths.dart` - File path management
- 🟡 `lib/core/services/debug/debugging_manager.dart` - Debug utilities
- 🟡 `lib/core/helpers/input_validator.dart` - Form validation logic

### Extensions
- 🟡 `lib/core/extensions/build_context_l10n.dart` - Localization extensions
- 🟡 `lib/core/resources/themes/extensions/color_extensions.dart` - Color utilities
- 🟡 `lib/core/services/router/app_navigator.dart` - Navigation helpers

### Error Handling
- 🔴 `lib/core/resources/errors/failures.dart` - Failure classes
- 🔴 `lib/core/resources/errors/exceptions.dart` - Exception classes

## 🧪 Domain Entities (Business Logic)

### Key Domain Entities to Test
- 🔴 `lib/features/tests/domain/entities/result.dart` - Result business logic (scoring, validation)
- 🟡 `lib/features/tests/domain/entities/question.dart` - Question validation
- 🟡 `lib/features/auth/domain/entites/user_data.dart` - User data validation
- 🟡 `lib/features/notifications/domain/entities/app_notification.dart` - Notification logic

## 📝 Testing Strategy by Priority

### Phase 1: High Priority (🔴)
Start with these files as they contain the most critical business logic:

1. **Core Functionality**
   - Authentication (models, use cases, repositories, data sources)
   - Test results and scoring logic
   - Question and answer handling
   - Error handling and mapping

2. **Critical Data Models**
   - User data, questions, results, options
   - JSON serialization/deserialization
   - Entity mapping

### Phase 2: Medium Priority (🟡)
Move to these after completing high priority:

1. **Supporting Features**
   - Settings management
   - Units and lessons
   - Cache management
   - Input validation

### Phase 3: Low Priority (🟢)
Complete these for comprehensive coverage:

1. **UI and Presentation Logic**
   - Presentation models
   - Navigation helpers
   - Theme extensions

## 📊 Testing Focus Areas

For each file, ensure you test:

### Data Models
- ✅ JSON serialization (`toJson()`)
- ✅ JSON deserialization (`fromJson()`)
- ✅ Edge cases (null values, invalid data)
- ✅ Entity conversion methods

### Use Cases
- ✅ Success scenarios
- ✅ Failure scenarios
- ✅ Edge cases and validation
- ✅ Repository interaction

### Repositories
- ✅ Remote data source calls
- ✅ Local data source calls
- ✅ Error handling and mapping
- ✅ Data transformation

### Data Sources
- ✅ API calls and responses
- ✅ Error scenarios (network, server errors)
- ✅ Data parsing and validation
- ✅ Cache operations

### Core Services
- ✅ Service initialization
- ✅ Method functionality
- ✅ Error handling
- ✅ State management

## 🎯 Quick Start Guide

1. **Pick one feature** (recommend starting with Auth or Tests)
2. **Write tests in this order:**
   - Data models (JSON parsing)
   - Use cases (business logic)
   - Repositories (data flow)
   - Data sources (external calls)
3. **Use AAA pattern:**
   - **Arrange**: Set up test data
   - **Act**: Execute the function
   - **Assert**: Verify expected results
4. **Mock dependencies** using `mockito` or `mocktail`
5. **Test both success and failure scenarios**

Remember: Start small, focus on critical paths first, and build your testing skills gradually!
