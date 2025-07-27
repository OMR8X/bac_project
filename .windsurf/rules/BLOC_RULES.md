---
trigger: manual
description: when creating anything reletead to bloc(bloc state managments)
---

# BLoC Pattern Rules for Flutter App (Dynamic Naming)

## General Rules
- Use `bloc` and `equatable` packages.
- when creating a states, make the first and base state extends equatable , other will extends the base state.
- Split files using `part`:
  - `*_bloc.dart`
  - `*_event.dart`
  - `*_state.dart`
- handle all events using functions in *_bloc.dart in super method of constructer.
- Use private function handlers inside the Bloc class with a `_` prefix.
- when creating bloc , you will create in part you working on it in presentatoin layer as: lib/presentation/{part you working on}/blocs/{folder with bloc name}/{bloc parts like `*_bloc.dart` ,`*_event.dart`,`*_state.dart`}
- IMPORTANT: when creating bloc if there are : lib/core/injector/controllers_injection.dart file
  you should add bloc to it and inject it using register factory or single tone as needed.

## Naming Conventions
- Prefix all **state** and **event** class names with the BLoC name in PascalCase.
  - Example: For `PostsBloc`, use:
    - States: `PostsInitial`, `PostsLoading`, `PostsLoaded`, `PostsError`.
    - Events: `PostsEventInitialize`, `PostsEventRefresh`, etc.
- This applies to all states (`Initial`, `Loading`, `Loaded`, `Error`) and events.

## Error Handling
- Always define an `<BlocName>Error` state with a `String message`.

## Example Template
```dart
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsEventInitialize>(_onInitialize);
    on<PostsEventRefresh>(_onRefresh);
  }

  Future<void> _onInitialize(
      PostsEventInitialize event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    try {
      final posts = await Api.fetchPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> _onRefresh(
      PostsEventRefresh event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    try {
      final posts = await Api.fetchPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}