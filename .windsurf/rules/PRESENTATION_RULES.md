---
trigger: manual
description: when creating anytheing releated to view , widget , components , blocs
---

# Presentation Layer Rules for Flutter Project

## 🏛️ Architecture
- The Presentation layer is responsible only for UI, state management, and user interactions.
- No business logic should exist in the presentation layer — it must rely on the domain and data layers.

## 📁 File & Folder Structure
- UI components are placed in `/lib/presentation/`.
- Organize by feature/module:
  - `/lib/presentation/<feature>/widgets/` – Reusable widgets.
  - `/lib/presentation/<feature>/views/` – Full screens or pages.
  - `/lib/presentation/<feature>/bloc/` – BLoC files (`bloc`, `event`, `state`).
  - `/lib/presentation/<feature>/providers/` – For Riverpod (if used).

## 🎨 Widget Rules
- Use **StatelessWidget** whenever possible.
- StatefulWidgets are allowed only for local UI states, animations, or controllers.
- Widgets must be small, focused, and reusable.

## 🧠 State Management
- Use BLoC — follow the project’s primary choice.
- UI listens to state changes and rebuilds based on:
  - `Loading` → Show loading indicator.
  - `Loaded` → Show data.
  - `Error` → Show error message.
- No direct API calls or database calls in the UI — only interact with BLoC or Riverpod providers.

## 🎯 Naming Conventions
- Views: `<Feature>View`(e.g., `HomeView`).
- Widgets: Describe functionality (`UnitCardWidget`).
- Bloc files:
  - `<feature>_bloc.dart`
  - `<feature>_event.dart`
  - `<feature>_state.dart`





## 🚦 Error Handling
- On error states (`<Feature>Error`):
  - Show a standard error widget or snackbar.
  - Allow users to retry if applicable.

## 🔍 Example File Structure for Feature `Home`: