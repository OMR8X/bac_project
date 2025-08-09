part of 'search_bloc.dart';

enum SearchStatus { initial, searching }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<Lesson> lessons;
  final String? message;

  const SearchState({
    this.status = SearchStatus.initial,
    this.lessons = const [],
    this.message,
  });

  SearchState copyWith({
    SearchStatus? status,
    List<Lesson>? lessons,
    String? message,
  }) {
    return SearchState(
      status: status ?? this.status,
      lessons: lessons ?? this.lessons,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, lessons, message];
}
