part of 'app_loader_bloc.dart';

enum LoadState { failure, loading, update, succeed }

final class AppLoaderState extends Equatable {
  //
  final LoadState state;
  final Version version;
  final Failure? failure;
  //
  const AppLoaderState({required this.state, required this.failure, required this.version});
  //
  factory AppLoaderState.loading() {
    return AppLoaderState(state: LoadState.loading, failure: null, version: Version.empty());
  }
  //
  factory AppLoaderState.failure({required Failure failure, LoadState? state}) {
    return AppLoaderState(
      state: state ?? LoadState.failure,
      failure: failure,
      version: Version.empty(),
    );
  }
  //
  factory AppLoaderState.succeed() {
    return AppLoaderState(state: LoadState.succeed, failure: null, version: Version.empty());
  }
  //
  factory AppLoaderState.update({required Version version}) {
    return AppLoaderState(
      state: LoadState.update,
      failure: null,
      version: version ,
    );
  }
  @override
  List<Object?> get props => [state, failure, version];

  
}
