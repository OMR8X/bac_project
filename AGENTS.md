---
alwaysApply: true
---
Architecture

## Overview
Flutter mobile application built with Clean Architecture, featuring a modular structure organized around features.

## Core Technologies
- **Framework**: Flutter (Dart)
- **Architecture**: Clean Architecture with Feature-Driven Development
- **State Management**: BLoC Pattern (flutter_bloc)
- **Backend**: Supabase (PostgreSQL + Edge Functions)
- **Dependency Injection**: GetIt
- **Networking**: Dio HTTP client
- **Local Storage**: Hive
- **Authentication**: Supabase Auth
- **Push Notifications**: Firebase Cloud Messaging + Local Notifications
- **Routing**: Go Router
- **Localization**: ARB-based internationalization

## Project Structure

### `lib/core/` - Shared Layer
Contains reusable components, services, and utilities:
- **Services**: API client, cache manager, router, logging, tokens management
- **Resources**: Themes, styles, colors, fonts, error handling
- **Widgets**: Common UI components (snackbars, dialogs, loading states)
- **Injector**: Dependency injection setup for all features

### `lib/features/` - Feature Layer
Each feature follows Clean Architecture with `data/` and `domain/` layers:
- **data/**: Data sources, models, repositories implementations, API responses, mappers
- **domain/**: Business entities, repository interfaces, use cases, request models

**Features**: `auth`, `notifications`, `settings`, `tests`

### `lib/presentation/` - Presentation Layer
UI code organized by screens/views:
- **State**: BLoC implementations for each screen
- **Views**: Screen widgets
- **Widgets**: Reusable UI components per feature

### `database/` - Backend Schema Files
Contains Supabase PostgreSQL database schema, functions, and data management files. This directory holds all SQL code that defines and populates the database structure.

**Directory Contents:**

- **`database/tables.sql`**: Defines all database table schemas.

- **`database/api_response.sql`**: Defines the standardized response format used across all database functions.

- **`database/functions/`** directory: Each file represents a PostgreSQL remote function for database operations.

- **`database/seeders/`** directory: SQL files that populate the database with initial/test data.


### `supabase/` - Supabase Project Configuration
Contains Supabase project configuration and serverless Edge Functions. This directory holds the Supabase project setup and backend serverless logic.

**Directory Contents:**

- **`supabase/config.toml`**: Project configuration file for local development environment and Supabase services.

- **`supabase/functions/`** directory: Serverless Edge Functions running on Deno runtime. Each function has its own subdirectory with an `index.ts` entry point.

## Key Patterns
- **Clean Architecture**: Strict separation between data, domain, and presentation layers
- **Repository Pattern**: Abstraction over data sources
- **Dependency Injection**: Centralized service management
- **Feature Modules**: Independent, self-contained features
- **BLoC Pattern**: Predictable state management

## Localization Practices

The application uses ARB-based internationalization for managing localized strings. All localization keys and values are managed through a single source of truth.

### Localization File
- **`lib/l10n/app_ar.arb`**: The primary localization file containing all Arabic (AR) translations
- This is the **only** file where localization keys and values should be added or updated
- Flutter automatically generates localization classes from this ARB file

### Adding New Localization Keys
1. Open `lib/l10n/app_ar.arb`
2. Add a new key-value pair in JSON format: `"keyName": "Translation Value"`
3. Flutter will auto-generate the corresponding getter in the localization classes
4. Use the generated value in code via `context.l10n.keyName`

### Usage in Code
- Access localized strings using the generated `context.l10n` extension
- Example: `Text(context.l10n.homeTitle)` will display "الرئيسية"
- The generated classes are available in `lib/l10n/generated/app_localizations.dart` and `lib/l10n/generated/app_localizations_ar.dart`

### Important Notes
- **Never** manually edit the generated files in `lib/l10n/generated/`
- **Always** make changes to `lib/l10n/app_ar.arb` only
- After adding or updating keys, Flutter will automatically regenerate the localization classes on the next build

## Backend Synchronization Practices

Maintain bidirectional sync between local files and remote Supabase backend. Use Supabase MCP tools to apply local changes to remote database/edge functions, and update local files when remote changes occur.

### Database Functions (`database/functions/`)
- Keep local SQL files and remote database synced

### Database Tables (`database/tables.sql`)
- Keep local SQL files and remote database synced
- Schema changes may require updating seeders in `database/seeders/`

### Database Seeders (`database/seeders/`)
- Update when schema changes, data modifications, or new tables added
- Keep local files and remote database synced

### Supabase Edge Functions (`supabase/functions/`)
- Keep local files and remote edge functions synced

