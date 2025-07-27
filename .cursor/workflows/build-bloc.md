---
description: build bloc
---

```
presentation/
└── [feature_name]/
    ├── blocs/
    │   └── [bloc_name]_bloc/
    │       ├── [bloc_name]_bloc.dart
    │       ├── [bloc_name]_event.dart
    │       └── [bloc_name]_state.dart
    └── views/
        └── [bloc_name]_view.dart
```

## i want to Implementat these Steps one after one

1. Verify Feature Directory
You will be provided with the feature folder location. Work within the provided feature directory.

2. Create BLoC Folder & File Structure
Within the provided feature directory, create the following structure:

**Create these folders:**
1. `blocs/` folder (if it doesn't exist)
2. `blocs/[bloc_name]_bloc/` folder
3. `views/` folder (if it doesn't exist)

**Create these files:**
- `blocs/[bloc_name]_bloc/[bloc_name]_bloc.dart`
- `blocs/[bloc_name]_bloc/[bloc_name]_event.dart`
- `blocs/[bloc_name]_bloc/[bloc_name]_state.dart`
- `views/[bloc_name]_view.dart`

Replace `[bloc_name]` with your actual bloc name.

3. Implement Event File (`[bloc_name]_event.dart`)
**Important**: Always work under to the specific `.windsurf/rules/bloc/create_bloc_event_rules.md` rule file to get instructions to create it correctly.

4. Implement State File (`[bloc_name]_state.dart`)
**Important**: Always work under the specific `.windsurf/rules/bloc/create_bloc_state_rules.md` rule file to get instructions to create it correctly.

5. Implement BLoC Class (`[bloc_name]_bloc.dart`)
**Important**: Always work under the specific `.windsurf/rules/bloc/create_bloc_class_rules.md` rule file to get instructions to create it correctly.

6. Implement View File (`[bloc_name]_view.dart`)
**Important**: Always work under the specific `.windsurf/rules/bloc/create_bloc_view_rules.md` rule file to get instructions to create it correctly.