# Supabase Database Schema

## Tables

This directory contains SQL definitions for the following tables:

1. `units.sql`: Stores educational units
2. `lessons.sql`: Stores lessons within units
3. `questions.sql`: Stores questions for lessons
4. `options.sql`: Stores multiple-choice options for questions
5. `results.sql`: Stores user test results
6. `governorates.sql`: Stores governorate information
7. `sections.sql`: Stores section information
8. `categories.sql`: Stores question categories
9. `question_categories.sql`: Mapping between questions and categories

## Functions

Functions are organized into the following categories:

### Triggers
- `fn_update_updated_at.sql`: Generic trigger function to update `updated_at` timestamp
- `fn_units_update_updated_at.sql`: Trigger function for updating units' `updated_at`
- `fn_lessons_update_updated_at.sql`: Trigger function for updating lessons' `updated_at`

### Data Management
- `add_question_with_options.sql`: Adds a question with multiple options
- `add_user_result.sql`: Adds a user's test result with score calculation

### Analytics
- `get_user_results.sql`: Retrieves user test results with optional filtering

### API
- `fn_api_get_user_results.sql`: API function to get user results with lesson titles
- `fn_api_lessons_get_questions.sql`: API function to get questions for lessons with filtering
- `fn_api_settings_get_app_settings.sql`: API function to get app settings and user data
- `fn_api_units_get_total_units.sql`: API function to get all units with lesson counts
- `fn_api_add_user_result.sql`: API function to add user results with authentication
- `fn_api_questions_get_test_options.sql`: API function to get test options and categories
- `add_user_result.sql`: API function to add user results (alternative version)
- `fn_api_lessons_get_total_lessons.sql`: API function to get lessons with search and filtering

### Utility
*(Currently empty - reserved for future utility functions)*

## Notes

- These SQL files represent the current database schema at the time of export
- Some functions are trigger functions that automatically update timestamps
- The schema includes relationships between tables (foreign key constraints)
- All timestamps default to the current time
- Most tables have an `is_visible` flag for soft deletion/filtering

## Function Categories Explained

- **Triggers**: Functions that automatically modify database records (e.g., updating timestamps)
- **Data Management**: Functions that insert or modify data with complex logic
- **Analytics**: Functions that retrieve and process data for reporting or analysis
- **API**: Functions exposed as API endpoints for the application frontend
- **Utility**: General-purpose helper functions that don't fit into other categories
