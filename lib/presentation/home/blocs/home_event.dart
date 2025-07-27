part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeEventInitialize extends HomeEvent {
  const HomeEventInitialize();

  @override
  List<Object> get props => [];
}

final class HomeEventRefresh extends HomeEvent {
  const HomeEventRefresh();

  @override
  List<Object> get props => [];
}
