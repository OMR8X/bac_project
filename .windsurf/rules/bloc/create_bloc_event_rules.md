---
trigger: manual
---

# BLoC Event Rules and Guidelines

## Overview
Events represent user actions, system events, or any trigger that causes a state change in the BLoC. Events are the input to the BLoC and should be immutable.

## Step-by-Step Event Creation Process

### Step 1: File Structure and Naming
- **File naming convention**: `{feature_name}_event.dart`
- **Location**: Place in the same directory as the BLoC files
- **Example**: `authentication_event.dart`, `counter_event.dart`

### Step 2: Required bloc main class file
```dart
part of '{feature_name}_bloc.dart';
```
- **Purpose**: Equatable helps with value comparison and prevents unnecessary rebuilds
- **Alternative**: If not using Equatable, override `==` and `hashCode` manually

### Step 3: Base Event Class Declaration
```dart
sealed class {FeatureName}Event extends Equatable {
  const {FeatureName}Event();

  @override
  List<Object> get props => [];
}
```
- **Naming**: Use PascalCase with "Event" suffix
- **Sealed**: Base class should be sealed to enable exhaustive pattern matching
- **Const constructor**: Ensures immutability
- **Props**: Override props for Equatable comparison

### Step 4: Define Specific Events
For each specific event, follow this pattern:

#### 4.1 Simple Events (No Parameters)
```dart
final class {FeatureName}{ActionName} extends {FeatureName}Event {
  const {FeatureName}{ActionName}();
}
```
- **Use case**: Events that don't require additional data
- **Example**: `CounterStarted`, `UserLoggedOut`, `DataRefreshed`
- **Naming**: Use past tense verbs to indicate completed actions

#### 4.2 Events with Parameters
```dart
final class {FeatureName}{ActionName} extends {FeatureName}Event {
  final {DataType} {parameterName};
  
  const {FeatureName}{ActionName}({required this.{parameterName}});

  @override
  List<Object> get props => [{parameterName}];
}
```
- **Required parameters**: Use `required` keyword for mandatory fields
- **Props override**: Include all parameters in props list for proper comparison
- **Immutability**: All fields should be final
- **Naming**: Use past tense verbs (e.g., `UserNameChanged`, `ItemSelected`)

#### 4.3 Events with Multiple Parameters
```dart
final class {FeatureName}{ActionName} extends {FeatureName}Event {
  final {DataType1} {parameter1};
  final {DataType2} {parameter2};
  
  const {FeatureName}{ActionName}({
    required this.{parameter1},
    required this.{parameter2},
  });

  @override
  List<Object> get props => [{parameter1}, {parameter2}];
}
```

### Step 5: Event Naming Conventions
- **Past tense**: Events should be named in past tense (things that have already occurred)
- **Anatomy**: `BlocSubject` + `Noun (optional)` + `Verb (event)`
- **Initial events**: Use `BlocSubject` + `Started` for initialization
- **Clear and descriptive**: Event names should clearly indicate what happened

### Step 6: Event Categories and Organization

#### 6.1 Lifecycle Events
- Initialization events: `Initialize`, `Start`, `Load`
- Cleanup events: `Dispose`, `Reset`, `Clear`

#### 6.2 User Action Events
- Input events: `TextChanged`, `ButtonPressed`, `ItemTapped`
- Navigation events: `NavigateToScreen`, `GoBack`

#### 6.3 System Events
- Success events: `DataLoadSuccess`, `OperationCompleted`
- Error events: `ErrorOccurred`, `NetworkFailure`

### Step 7: Error Handling in Events
```dart
final class {FeatureName}{ActionName}Failed extends {FeatureName}Event {
  final String errorMessage;
  final Exception? exception;
  
  const {FeatureName}{ActionName}Failed({
    required this.errorMessage,
    this.exception,
  });

  @override
  List<Object> get props => [errorMessage];
}
```

### Step 8: Documentation and Comments
- **Purpose**: Document what triggers each event
- **Parameters**: Explain what each parameter represents
- **Usage**: Provide examples of when to use each event

### Step 9: Event Validation
- **Parameter validation**: Ensure all required parameters are provided
- **Type safety**: Use appropriate data types
- **Null safety**: Handle nullable parameters correctly
å

## Best Practices Summary
1. **Use sealed base class for exhaustive pattern matching**
2. **Use final class for concrete event implementations**
3. **Use const constructors for immutability**
4. **Override props for Equatable comparison**
5. **Use past tense naming convention (BlocSubject + Verb)**
6. **Start initialization events with 'Started' suffix**
7. **Group related events logically**
8. **Document complex events with comments**
9. **Validate parameters when necessary**
10. **Handle errors with specific error events**