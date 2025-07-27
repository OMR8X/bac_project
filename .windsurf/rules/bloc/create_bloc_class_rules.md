---
alwaysApply: false
---
# BLoC Class Rules and Guidelines


## Overview
The BLoC (Business Logic Component) is the core class that manages the state of your application feature. It receives events, processes business logic, and emits new states. The BLoC acts as a bridge between the UI and the data layer.

## Step-by-Step BLoC Class Creation Process

### Step 1: File Structure and Naming
- **File naming convention**: `{feature_name}_bloc.dart`
- **Location**: Place in the same directory as the event and state files
- **Example**: `authentication_bloc.dart`, `counter_bloc.dart`

### Step 2: Required Imports
```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Import your event and state files
import '{feature_name}_event.dart';
import '{feature_name}_state.dart';

// Import any dependencies (repositories, services, etc.)
import 'package:your_app/repositories/{feature_name}_repository.dart';
```

### Step 3: BLoC Class Declaration
```dart
class {FeatureName}Bloc extends Bloc<{FeatureName}Event, {FeatureName}State> {
  // Constructor
  {FeatureName}Bloc({
    required {DependencyType} dependency,
  }) : _dependency = dependency,
       super(const {FeatureName}Initial()) {
    
    // Register event handlers
    on<{EventName}>(_on{EventName});
    on<{AnotherEventName}>(_on{AnotherEventName});
  }

  // Private dependencies
  final {DependencyType} _dependency;
  
  // Event handlers
  // Implementation details follow...
}
```

### Step 4: Constructor Guidelines
- **Dependency injection**: Accept all required dependencies through constructor
- **Private fields**: Store dependencies as private final fields
- **Initial state**: Always provide an initial state in super constructor
- **Event registration**: Register all event handlers in constructor

### Step 5: Event Handler Implementation

#### 5.1 Simple Event Handler Pattern
```dart
Future<void> _on{FeatureName}{EventName}(
  {FeatureName}{EventName} event,
  Emitter<{FeatureName}State> emit,
) async {
  // Emit loading state if needed
  emit(const {FeatureName}LoadInProgress());
  
  try {
    // Business logic here
    final result = await _dependency.performOperation();
    
    // Emit success state
    emit({FeatureName}LoadSuccess(data: result));
  } catch (exception) {
    // Emit failure state
    emit({FeatureName}LoadFailure(
      errorMessage: exception.toString(),
      exception: exception,
    ));
  }
}
```

#### 5.2 Event Handler with Parameters
```dart
Future<void> _on{FeatureName}{EventName}(
  {FeatureName}{EventName} event,
  Emitter<{FeatureName}State> emit,
) async {
  // Validate event parameters
  if (event.parameter.isEmpty) {
    emit(const {FeatureName}LoadFailure(
      errorMessage: 'Parameter cannot be empty',
    ));
    return;
  }
  
  emit(const {FeatureName}LoadInProgress());
  
  try {
    // Use event parameters
    final result = await _dependency.performOperation(event.parameter);
    
    emit({FeatureName}LoadSuccess(data: result));
  } catch (exception) {
    emit({FeatureName}LoadFailure(
      errorMessage: 'Operation failed: ${exception.toString()}',
      exception: exception,
    ));
  }
}
```

#### 5.3 Event Handler with State Transition Logic
```dart
Future<void> _on{FeatureName}{EventName}(
  {FeatureName}{EventName} event,
  Emitter<{FeatureName}State> emit,
) async {
  // Only process if in correct state
  if (state is! {FeatureName}LoadSuccess) {
    emit(const {FeatureName}LoadFailure(
      errorMessage: 'Invalid state for this operation',
    ));
    return;
  }
  
  final currentState = state as {FeatureName}LoadSuccess;
  
  // Emit loading state while processing
  emit(const {FeatureName}LoadInProgress());
  
  try {
    final result = await _dependency.performOperation();
    
    emit({FeatureName}LoadSuccess(data: result));
  } catch (exception) {
    emit({FeatureName}LoadFailure(
      errorMessage: exception.toString(),
      exception: exception,
    ));
  }
}
```

### Step 6: Event Handler Naming Convention
- **Private methods**: All event handlers should be private (prefixed with _)
- **Consistent naming**: Use `_on{EventName}` pattern
- **Descriptive names**: Handler names should clearly indicate what they do

### Step 7: State Management Best Practices

#### 7.1 State Transitions
```dart
// Always check current state before transitions
if (state is {FeatureName}LoadInProgress) {
  // Prevent duplicate loading states
  return;
}

// Use type checking for state-specific logic
if (state is {FeatureName}LoadSuccess) {
  final currentState = state as {FeatureName}LoadSuccess;
  // Work with current state data
}

// Pattern matching with sealed classes
switch (state) {
  case {FeatureName}Initial():
    // Handle initial state
    break;
  case {FeatureName}LoadInProgress():
    // Handle loading state
    break;
  case {FeatureName}LoadSuccess():
    // Handle success state
    break;
  case {FeatureName}LoadFailure():
    // Handle failure state
    break;
}
```

#### 7.2 Loading States
```dart
// Show loading for async operations
emit(const {FeatureName}LoadInProgress());

// For single class approach with status enum
if (state is {FeatureName}State) {
  emit((state as {FeatureName}State).copyWith(
    status: {FeatureName}Status.loading,
  ));
}
```

#### 7.3 Error Handling
```dart
// Comprehensive error handling
try {
  final result = await _dependency.performOperation();
  emit({FeatureName}LoadSuccess(data: result));
} on NetworkException catch (e) {
  emit({FeatureName}LoadFailure(
    errorMessage: 'Network error: ${e.message}',
    exception: e,
  ));
} on ValidationException catch (e) {
  emit({FeatureName}LoadFailure(
    errorMessage: 'Validation error: ${e.message}',
    exception: e,
  ));
} catch (e) {
  emit({FeatureName}LoadFailure(
    errorMessage: 'Unexpected error: ${e.toString()}',
    exception: e,
  ));
}
```

### Step 8: Dependency Management
```dart
class {FeatureName}Bloc extends Bloc<{FeatureName}Event, {FeatureName}State> {
  {FeatureName}Bloc({
    required {Repository} repository,
    required {Service} service,
    {OptionalDependency}? optionalDependency,
  }) : _repository = repository,
       _service = service,
       _optionalDependency = optionalDependency,
       super(const {FeatureName}Initial()) {
    
    on<{EventName}>(_on{EventName});
  }

  final {Repository} _repository;
  final {Service} _service;
  final {OptionalDependency}? _optionalDependency;
}
```

### Step 9: Complex Business Logic Patterns

#### 9.1 Debouncing Events
```dart
Future<void> _on{EventName}(
  {EventName} event,
  Emitter<{FeatureName}State> emit,
) async {
  // Debounce rapid events
  await Future.delayed(const Duration(milliseconds: 300));
  
  // Check if event is still relevant
  if (event != _lastEvent) return;
  
  // Process event
  _performSearch(event.query, emit);
}
```

#### 9.2 Pagination Logic
```dart
Future<void> _onLoadMore(
  LoadMoreEvent event,
  Emitter<{FeatureName}State> emit,
) async {
  if (state is! {FeatureName}Loaded) return;
  
  final currentState = state as {FeatureName}Loaded;
  
  // Prevent loading if already loading or reached max
  if (currentState.isLoading || currentState.hasReachedMax) {
    return;
  }
  
  emit(currentState.copyWith(isLoading: true));
  
  try {
    final newItems = await _repository.getItems(
      page: currentState.currentPage + 1,
    );
    
    final hasReachedMax = newItems.isEmpty || newItems.length < _pageSize;
    
    emit(currentState.copyWith(
      items: [...currentState.items, ...newItems],
      currentPage: currentState.currentPage + 1,
      isLoading: false,
      hasReachedMax: hasReachedMax,
    ));
  } catch (exception) {
    emit(currentState.copyWith(
      isLoading: false,
      errorMessage: exception.toString(),
    ));
  }
}
```

### Step 10: BLoC Lifecycle Management
```dart
class {FeatureName}Bloc extends Bloc<{FeatureName}Event, {FeatureName}State> {
  // Constructor...
  
  @override
  Future<void> close() {
    // Cleanup resources
    _subscription?.cancel();
    _timer?.cancel();
    
    return super.close();
  }
  
  @override
  void onChange(Change<{FeatureName}State> change) {
    super.onChange(change);
    
    // Debug logging
    if (kDebugMode) {
      print('${runtimeType} $change');
    }
  }
  
  @override
  void onTransition(Transition<{FeatureName}Event, {FeatureName}State> transition) {
    super.onTransition(transition);
    
    // Debug logging
    if (kDebugMode) {
      print('${runtimeType} $transition');
    }
  }
  
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    
    // Error logging
    print('${runtimeType} Error: $error');
    print('Stack trace: $stackTrace');
  }
}
```

### Step 11: Complete Example Template
```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '{feature_name}_event.dart';
import '{feature_name}_state.dart';
import 'package:your_app/repositories/{feature_name}_repository.dart';

class {FeatureName}Bloc extends Bloc<{FeatureName}Event, {FeatureName}State> {
  {FeatureName}Bloc({
    required {Repository} repository,
  }) : _repository = repository,
       super(const {FeatureName}Initial()) {
    
    // Register event handlers
    on<{FeatureName}Started>(_on{FeatureName}Started);
    on<{FeatureName}DataRequested>(_on{FeatureName}DataRequested);
    on<{FeatureName}Refreshed>(_on{FeatureName}Refreshed);
  }

  final {Repository} _repository;

  // Event handlers
  Future<void> _on{FeatureName}Started(
    {FeatureName}Started event,
    Emitter<{FeatureName}State> emit,
  ) async {
    emit(const {FeatureName}LoadInProgress());
    
    try {
      final data = await _repository.getInitialData();
      emit({FeatureName}LoadSuccess(data: data));
    } catch (exception) {
      emit({FeatureName}LoadFailure(
        errorMessage: exception.toString(),
        exception: exception,
      ));
    }
  }

  Future<void> _on{FeatureName}DataRequested(
    {FeatureName}DataRequested event,
    Emitter<{FeatureName}State> emit,
  ) async {
    emit(const {FeatureName}LoadInProgress());
    
    try {
      final data = await _repository.getData(event.parameter);
      emit({FeatureName}LoadSuccess(data: data));
    } catch (exception) {
      emit({FeatureName}LoadFailure(
        errorMessage: exception.toString(),
        exception: exception,
      ));
    }
  }

  Future<void> _on{FeatureName}Refreshed(
    {FeatureName}Refreshed event,
    Emitter<{FeatureName}State> emit,
  ) async {
    if (state is! {FeatureName}LoadSuccess) return;
    
    emit(const {FeatureName}LoadInProgress());
    
    try {
      final data = await _repository.refreshData();
      emit({FeatureName}LoadSuccess(data: data));
    } catch (exception) {
      emit({FeatureName}LoadFailure(
        errorMessage: exception.toString(),
        exception: exception,
      ));
    }
  }

  @override
  Future<void> close() {
    // Cleanup resources
    return super.close();
  }
}
```

## Best Practices Summary
1. **Single responsibility**: Each BLoC should handle one feature
2. **Immutable states**: Always emit immutable states
3. **Error handling**: Implement comprehensive error handling
4. **State validation**: Validate current state before transitions
5. **Dependency injection**: Use constructor injection for dependencies
6. **Private handlers**: Keep event handlers private
7. **Async operations**: Handle async operations properly
8. **Resource cleanup**: Clean up resources in close method
9. **Logging**: Add debug logging for development
10. **Testing**: Design for testability with clear dependencies
description:
globs:
alwaysApply: false
---
