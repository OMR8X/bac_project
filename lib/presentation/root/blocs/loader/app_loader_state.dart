part of 'app_loader_bloc.dart';

// to do : implement check connection state
enum LoadState { failure, loading, update, succeed, unauthorized, offline }

final class AppLoaderState extends Equatable {
  //
  final bool hasFinish;
  final LoadState state;
  final Version version;
  final Failure? failure;
  //
  const AppLoaderState({
    required this.state,
    required this.failure,
    required this.version,
    required this.hasFinish,
  });
  //
  factory AppLoaderState.loading() {
    return AppLoaderState(
      state: LoadState.loading,
      failure: null,
      version: Version.empty(),
      hasFinish: false,
    );
  }
  //
  factory AppLoaderState.failure({required Failure failure, LoadState? state}) {
    return AppLoaderState(
      state: state ?? LoadState.failure,
      failure: failure,
      version: Version.empty(),
      hasFinish: false,
    );
  }
  //
  factory AppLoaderState.succeed() {
    return AppLoaderState(
      state: LoadState.succeed,
      failure: null,
      version: Version.empty(),
      hasFinish: true,
    );
  }
  //
  factory AppLoaderState.unauthorized() {
    return AppLoaderState(
      state: LoadState.unauthorized,
      failure: null,
      version: Version.empty(),
      hasFinish: true,
    );
  }
  //
  factory AppLoaderState.update({required Version version}) {
    return AppLoaderState(
      state: LoadState.update,
      failure: null,
      version: version,
      hasFinish: true,
    );
  }
  @override
  List<Object?> get props => [state, failure, version, hasFinish];
}
