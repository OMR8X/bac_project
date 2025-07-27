---
alwaysApply: false
---




## Overview
This guide provides ready-to-use templates for creating BLoC views in Flutter. Views are UI components that display data and react to state changes from the BLoC. Each template handles specific states and provides clear separation between different state presentations.

**AI Model Usage**: Select the appropriate template based on your state management pattern and customize the placeholders with your specific feature details.

## Template Selection Guide

### Choose Your State Management Pattern:
1. **Multiple States Pattern**: Use when you have sealed classes with separate state classes
2. **Single State Pattern**: Use when you have one state class with status enum

### Common View States to Implement:
- **Initial View**: First load state
- **Loading View**: Data fetching state  
- **Success View**: Data loaded successfully
- **Error View**: Error occurred with retry option
- **Empty View**: No data available

## Template 1: Complete Multiple States Pattern

### File: `{feature_name}_bloc_view.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/{feature_name}_bloc.dart';
import '../bloc/{feature_name}_state.dart';

class {FeatureName}BlocView extends StatelessWidget {
  const {FeatureName}BlocView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
      create: (context) => {FeatureName}Bloc(),
      child: BlocBuilder<{FeatureName}Bloc, {FeatureName}State>(
        builder: (context, state) {
          if (state is {FeatureName}Initial) {
            return _{FeatureName}InitialView(state: state);
          } else if (state is {FeatureName}Loading) {
            return _{FeatureName}LoadingView(state: state);
          } else if (state is {FeatureName}Success) {
            return _{FeatureName}SuccessView(state: state);
          } else if (state is {FeatureName}Error) {
            return _{FeatureName}ErrorView(state: state);
          } else if (state is {FeatureName}Empty) {
            return _{FeatureName}EmptyView(state: state);
          }
          return const _{FeatureName}DefaultView();
        },
      ),
     )
    );
  }
}

// Initial State View Template
class _{FeatureName}InitialView extends StatelessWidget {
  const _{FeatureName}InitialView({super.key, required this.state});
  
  final {FeatureName}Initial state;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

// Loading State View Template
class _{FeatureName}LoadingView extends StatelessWidget {
  const _{FeatureName}LoadingView({super.key, required this.state});
  
  final {FeatureName}Loading state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

// Success State View Template
class _{FeatureName}SuccessView extends StatelessWidget {
  const _{FeatureName}SuccessView({super.key, required this.state});
  
  final {FeatureName}Success state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{Feature Display Name}'),
      ),
      body: ListView.builder(
        itemCount: state.{dataList}.length,
        itemBuilder: (context, index) {
          final item = state.{dataList}[index];
          return ListTile(
            title: Text(item.{titleProperty}),
            subtitle: Text(item.{subtitleProperty}),
            leading: const Icon(Icons.{iconName}),
            onTap: () {
              // Handle item tap
              context.read<{FeatureName}Bloc>().add({FeatureName}SelectEvent(item));
            },
          );
        },
      ),
    );
  }
}

// Error State View Template
class _{FeatureName}ErrorView extends StatelessWidget {
  const _{FeatureName}ErrorView({super.key, required this.state});
  
  final {FeatureName}Error state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error Loading {Feature Display Name}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Empty State View Template
class _{FeatureName}EmptyView extends StatelessWidget {
  const _{FeatureName}EmptyView({super.key, required this.state});
  
  final {FeatureName}Empty state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No {feature_name} available',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try refreshing or check back later',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<{FeatureName}Bloc>().add({FeatureName}RefreshEvent());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

// Default State View Template
class _{FeatureName}DefaultView extends StatelessWidget {
  const _{FeatureName}DefaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: const Center(
        child: Text('Unknown State'),
      ),
    );
  }
}
```

## Template 2: Complete Single State Pattern

### File: `{feature_name}_bloc_view.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/{feature_name}_bloc.dart';
import '../bloc/{feature_name}_state.dart';

class {FeatureName}BlocView extends StatelessWidget {
  const {FeatureName}BlocView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
      create: (context) => {FeatureName}Bloc(),
      child: BlocBuilder<{FeatureName}Bloc, {FeatureName}State>(
        builder: (context, state) {
          switch (state.status) {
            case {FeatureName}Status.initial:
              return _{FeatureName}InitialView(state: state);
            case {FeatureName}Status.loading:
              return _{FeatureName}LoadingView(state: state);
            case {FeatureName}Status.success:
              return _{FeatureName}SuccessView(state: state);
            case {FeatureName}Status.error:
              return _{FeatureName}ErrorView(state: state);
            case {FeatureName}Status.empty:
              return _{FeatureName}EmptyView(state: state);
            default:
              return const _{FeatureName}DefaultView();
          }
        },
      ),
     )
    );
  }
}

// Initial Status View Template
class _{FeatureName}InitialView extends StatelessWidget {
  const _{FeatureName}InitialView({super.key, required this.state});
  
  final {FeatureName}State state;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

// Loading Status View Template
class _{FeatureName}LoadingView extends StatelessWidget {
  const _{FeatureName}LoadingView({super.key, required this.state});
  
  final {FeatureName}State state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

// Success Status View Template
class _{FeatureName}SuccessView extends StatelessWidget {
  const _{FeatureName}SuccessView({super.key, required this.state});
  
  final {FeatureName}State state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{Feature Display Name}'),
      ),
      body: ListView.builder(
        itemCount: state.{dataList}?.length ?? 0,
        itemBuilder: (context, index) {
          final item = state.{dataList}![index];
          return ListTile(
            title: Text(item.{titleProperty}),
            subtitle: Text(item.{subtitleProperty}),
            leading: const Icon(Icons.{iconName}),
            onTap: () {
              context.read<{FeatureName}Bloc>().add({FeatureName}SelectEvent(item));
            },
          );
        },
      ),
    );
  }
}

// Error Status View Template
class _{FeatureName}ErrorView extends StatelessWidget {
  const _{FeatureName}ErrorView({super.key, required this.state});
  
  final {FeatureName}State state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error Loading {Feature Display Name}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Empty Status View Template
class _{FeatureName}EmptyView extends StatelessWidget {
  const _{FeatureName}EmptyView({super.key, required this.state});
  
  final {FeatureName}State state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No ${state.emptyMessage ?? '{feature_name}'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try refreshing or check back later',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<{FeatureName}Bloc>().add({FeatureName}RefreshEvent());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

// Default Status View Template
class _{FeatureName}DefaultView extends StatelessWidget {
  const _{FeatureName}DefaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: const Center(
        child: Text('Unknown State'),
      ),
    );
  }
}
```

## Quick Reference Templates

### Minimal Loading View
```dart
class _{FeatureName}LoadingView extends StatelessWidget {
  const _{FeatureName}LoadingView({super.key, required this.state});
  
  final {StateType} state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
```

### Minimal Success View
```dart
class _{FeatureName}SuccessView extends StatelessWidget {
  const _{FeatureName}SuccessView({super.key, required this.state});
  
  final {StateType} state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: ListView.builder(
        itemCount: state.{dataList}.length,
        itemBuilder: (context, index) {
          final item = state.{dataList}[index];
          return ListTile(
            title: Text(item.{titleProperty}),
            subtitle: Text(item.{subtitleProperty}),
          );
        },
      ),
    );
  }
}
```

### Minimal Error View
```dart
class _{FeatureName}ErrorView extends StatelessWidget {
  const _{FeatureName}ErrorView({super.key, required this.state});
  
  final {StateType} state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Feature Display Name}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(state.{errorProperty} ?? 'An error occurred'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<{FeatureName}Bloc>().add({FeatureName}RetryEvent());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Template Customization Guide

### Placeholders to Replace:
- `{feature_name}` - lowercase feature name (e.g., 'posts', 'users')
- `{FeatureName}` - PascalCase feature name (e.g., 'Posts', 'Users')
- `{Feature Display Name}` - Human-readable name (e.g., 'Posts', 'User Management')
- `{StateType}` - Specific state type or main state class
- `{dataList}` - Property name for list data (e.g., 'posts', 'users')
- `{titleProperty}` - Property for list item title (e.g., 'title', 'name')
- `{subtitleProperty}` - Property for list item subtitle (e.g., 'description', 'email')
- `{iconName}` - Material icon name (e.g., 'article', 'person')
- `{errorProperty}` - Error message property (e.g., 'message', 'errorMessage')

### Common Event Names:
- `{FeatureName}LoadEvent` - Initial load
- `{FeatureName}RefreshEvent` - Refresh data
- `{FeatureName}RetryEvent` - Retry after error
- `{FeatureName}SelectEvent` - Select item

### Template Selection Strategy:
1. **For Simple Features**: Use minimal templates
2. **For Complex Features**: Use complete templates
3. **For Data Lists**: Use success templates with ListView.builder
4. **For Forms**: Customize templates with form-specific widgets
5. **For Real-time Data**: Add BlocListener for side effects

## AI Model Instructions

When generating BLoC views:
1. **Identify the state pattern** from the BLoC state file
2. **Select appropriate template** (Multiple States or Single State)
3. **Replace all placeholders** with actual feature-specific values
4. **Include only relevant state views** based on the BLoC states
5. **Ensure consistent naming** throughout the file
6. **Add proper imports** for the specific BLoC and state files