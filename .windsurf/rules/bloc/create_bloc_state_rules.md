---
trigger: manual
---

# BLoC State Creation Rules
This guide provides comprehensive instructions for creating BLoC states following official Bloc Library best practices and patterns.


### Step 0: Required bloc main class file
```dart
part of '{feature_name}_bloc.dart';
```

## Overview
There are two main approaches for modeling BLoC states, each with specific use cases. Choose the appropriate approach based on your feature requirements and complexity.


## Approach 1: Sealed Class and Subclasses (Recommended)
**Use when:** States are well-defined, exclusive, and have unique properties per state.

### Structure
Create a sealed base class with specific state subclasses:

```dart
sealed class [FeatureName]State {
  const [FeatureName]State();
}

final class [FeatureName][StateDescription] extends [FeatureName]State {
  const [FeatureName][StateDescription]();
}

final class [FeatureName][ActionDescription] extends [FeatureName]State {
  const [FeatureName][ActionDescription]();
}

final class [FeatureName][SuccessDescription] extends [FeatureName]State {
  const [FeatureName][SuccessDescription]({required this.data});
  
  final [DataType] data;
}

final class [FeatureName][ErrorDescription] extends [FeatureName]State {
  const [FeatureName][ErrorDescription]({required this.exception});
  
  final Exception exception;
}
```

### Benefits
- **Type Safety**: Compile-safe with no risk of accessing invalid properties
- **Explicit**: Clear separation between shared and state-specific properties
- **Exhaustive**: Switch statements ensure all states are handled
- **Maintainable**: Easy to add new states without breaking existing code

### Implementation Rules
1. **Base Class**: Always use `sealed class` for the base state
2. **Subclasses**: Use `final class` for each specific state
3. **Immutability**: All state classes should be immutable (`const` constructors)
4. **Properties**: Each state should only contain properties relevant to that specific state
5. **Naming**: Use contextual descriptions that match your domain (e.g., `UserAuthenticated`, `CartEmpty`, `UploadCompleted`)

### Naming Examples
- **Authentication**: `Unauthenticated`, `Authenticating`, `Authenticated`, `AuthenticationFailed`
- **Data Fetching**: `Empty`, `Fetching`, `Populated`, `Unavailable`
- **Form Processing**: `Editing`, `Validating`, `Submitting`, `Submitted`, `Invalid`
- **File Operations**: `Idle`, `Processing`, `Completed`, `Cancelled`, `Failed`

## Approach 2: Concrete Class and Status Enum
**Use when:** States share many properties or aren't strictly exclusive.

### Structure
Create a single concrete class with status enum:

```dart
enum [FeatureName]Status { [contextualState1], [contextualState2], [contextualState3] }

final class [FeatureName]State {
  const [FeatureName]State({
    this.status = [FeatureName]Status.[defaultState],
    this.data,
    this.message,
  });

  final [FeatureName]Status status;
  final [DataType]? data;
  final String? message;
  
  [FeatureName]State copyWith({
    [FeatureName]Status? status,
    [DataType]? data,
    String? message,
  }) {
    return [FeatureName]State(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}
```

### Benefits
- **Simple**: Easy to manage single class with status enum
- **Concise**: Fewer lines of code compared to sealed classes
- **Flexible**: Can represent multiple states simultaneously

### Implementation Rules
1. **Status Enum**: Always include a status enum to track current state
2. **Nullable Properties**: Make state-specific properties nullable
3. **Default Values**: Provide sensible defaults in constructor
4. **CopyWith**: Always implement `copyWith` method for state updates
5. **Contextual Naming**: Use domain-specific enum values (e.g., `playing`, `paused` for media player)

## Decision Matrix

| Factor | Sealed Classes | Concrete Class + Enum |
|--------|----------------|----------------------|
| Type Safety | ✅ High | ❌ Low |
| Code Volume | ❌ Verbose | ✅ Concise |
| State Exclusivity | ✅ Enforced | ❌ Manual |
| Shared Properties | ❌ Complex | ✅ Simple |
| Maintainability | ✅ High | ⚠️ Medium |
| Learning Curve | ⚠️ Medium | ✅ Low |

## Best Practices

### Naming Conventions
1. **Be Descriptive**: Use names that clearly describe what the state represents
2. **Domain Language**: Use terminology from your problem domain
3. **Avoid Generics**: Don't use generic terms like "Loading", "Success", "Error"
4. **Consistency**: Use consistent patterns within the same feature
5. **Context Matters**: Consider the user's perspective and business logic

### General Rules
1. **Immutability**: All states must be immutable
2. **Equality**: Implement `Equatable` when needed for state comparison
3. **Documentation**: Document each state's purpose and when it's emitted
4. **Consistency**: Use the same approach throughout your feature
5. **Testing**: Write tests for state transitions and edge cases

### Integration with BLoC
```dart
class [FeatureName]Bloc extends Bloc<[FeatureName]Event, [FeatureName]State> {
  [FeatureName]Bloc() : super(const [FeatureName][AppropriateState]()) {
    on<[EventName]>(_on[EventName]);
  }
  
  Future<void> _on[EventName](
    [EventName] event,
    Emitter<[FeatureName]State> emit,
  ) async {
    emit(const [FeatureName][ProcessingState]());
    
    try {
      // Business logic here
      emit([FeatureName][SuccessState](data: result));
    } catch (e) {
      emit([FeatureName][ErrorState](message: e.toString()));
    }
  }
}
```

## Summary
- **Choose Sealed Classes** for type safety, exclusive states, and complex state management
- **Choose Concrete Class + Enum** for simplicity, shared properties, and rapid development
- **Use contextual naming** that reflects your domain and business logic
- Always maintain immutability and follow consistent naming conventions
- Implement proper error handling and testing for all state transitions