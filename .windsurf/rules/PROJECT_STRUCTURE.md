---
trigger: manual
---

# Project Structure and Architecture Guide

This document outlines the architecture and folder structure of the Flutter project. Adhering to these guidelines is crucial for maintaining code quality, consistency, and scalability.

## 1. Overall Architecture

The project follows a **Feature-Based Architecture**. The code is organized by features, with a central `core` directory for shared functionalities.

- **`lib/`**: The main source code directory.
  - **`core/`**: Contains shared code, services, and utilities used across multiple features.
  - **`presentation/`**: Contains all UI-related code, organized by feature screens.
  - **`main.dart`**: The application's entry point.

---

## 2. Core Layer (`lib/core/`)

The `core` directory is the backbone of the application, providing foundational services and utilities.

- **`core/injector/`**: Handles dependency injection setup, likely using a service locator pattern (e.g., `get_it`). All services and Blocs should be registered here.
- **`core/services/`**: Contains business logic and data-access services (e.g., API clients, database handlers, repositories). This acts as the **Data Layer**.
- **`core/resources/`**: Holds application-wide resources like theme data, color palettes, string constants, and asset paths.
- **`core/widgets/`**: A library of common, reusable widgets shared across the entire application (e.g., custom buttons, loading indicators, dialogs).
- **`core/helpers/`**: Contains utility functions and helper classes that don't fit into other categories.

---

## 3. Presentation Layer (`lib/presentation/`)

The `presentation` layer contains all the user-facing components, organized by screen or feature.

- Each subdirectory inside `presentation/` represents a distinct feature or screen (e.g., `home`, `settings`, `result`).

### Feature Directory Structure

When creating a new feature (e.g., `new_feature`), it must follow this structure:

`lib/presentation/new_feature/`
- **`blocs/`**: Houses the business logic components for the feature.
  - `new_feature_bloc.dart`: The main BLoC/Cubit for the feature.
  - `new_feature_event.dart`: Defines the events that the BLoC can receive.
  - `new_feature_state.dart`: Defines the states that the BLoC can emit.
- **`views/`**: Contains the top-level widget for the feature's screen.
  - `new_feature_screen.dart` or `new_feature_view.dart`: The main widget that builds the page UI and provides the BLoC to its widget tree.
- **`widgets/`**: Holds smaller, reusable widgets that are specific to this feature.
- **`models/`**: (Optional) Contains any data models that are used exclusively by the presentation layer of this feature.

---

## 4. State Management

- **BLoC Pattern**: The project uses the BLoC (Business Logic Component) pattern for state management.
- **Provider**: Use `BlocProvider` to inject Blocs into the widget tree.
- **UI Updates**: Use `BlocBuilder` or `BlocListener` to react to state changes and rebuild the UI.
- **Events**: Widgets should send events to Blocs to trigger business logic, not modify the state directly.

---

## 5. Rules for AI Agents

1.  **Create New Features**: When asked to create a new feature, create a new directory in `lib/presentation/` and populate it with the standard `blocs`, `views`, and `widgets` subdirectories.
2.  **Add Business Logic**: Place all new business logic inside a BLoC in the corresponding feature's `blocs` directory.
3.  **Create UI**: New screens go in the `views` directory, and reusable feature-specific widgets go in the `widgets` directory.
4.  **Shared Code**: If a piece of code (widget, service, helper) will be used by more than one feature, place it in the appropriate directory within `lib/core/`.
5.  **Dependency Injection**: Register all new Blocs and Services in the `core/injector/` files to make them available throughout the app.