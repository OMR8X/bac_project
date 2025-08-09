part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchLessons extends SearchEvent {
  final int? unitId;
  final String? searchText;

  const SearchLessons({this.unitId, this.searchText});

  @override
  List<Object?> get props => [unitId, searchText];
}

class ClearSearch extends SearchEvent {}
