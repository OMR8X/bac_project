import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'app_loader_event.dart';
part 'app_loader_state.dart';

class AppLoaderBloc extends Bloc<AppLoaderLoadData, AppLoaderState> {
  AppLoaderBloc() : super(AppLoaderState.loading()) {
    on<AppLoaderLoadData>(onAppLoaderLoadData);
  }

  onAppLoaderLoadData(
    AppLoaderLoadData event,
    Emitter<AppLoaderState> emit,
  ) async {
    emit(AppLoaderState.succeed());
  }
}
