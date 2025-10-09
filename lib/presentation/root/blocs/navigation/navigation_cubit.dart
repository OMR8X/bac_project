import 'dart:async';

import 'package:bac_project/core/services/logs/logger.dart';
import 'package:bac_project/presentation/root/blocs/loader/app_loader_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/router/routes.dart';
import '../../../auth/state/bloc/auth_bloc.dart';
part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> with ChangeNotifier {
  NavigationCubit() : super(NavigationState.initializing());

  FutureOr<String?> redirect(BuildContext context, GoRouterState navState) {
    final current = navState.matchedLocation;

    switch (state.status) {
      ///
      case NavigationStatus.initializing:
        if (current == Routes.loader.path) break;
        setPendingRoute(current);
        return Routes.loader.path;

      ///
      case NavigationStatus.unauthorized:
        if (current == Routes.authentication.path) break;
        setPendingRoute(current);
        return Routes.authentication.path;

      ///
      case NavigationStatus.updateAvailable:
        if (current == Routes.updateAvailable.path) break;
        setPendingRoute(current);
        return Routes.updateAvailable.path;

      ///
      case NavigationStatus.ready:

        //
        final pendingRoute = state.pendingRoute;
        //
        if (pendingRoute != null) {
          clearPendingRoute();
          if (current != pendingRoute) {
            return pendingRoute;
          }
          break;
        }
        //
        if ([Routes.authentication.path, Routes.loader.path].contains(current)) {
          return Routes.home.path;
        }

      default:
        break;
    }

    return null;
  }

  void updateFromLoader(AppLoaderState loaderState) {
    switch (loaderState.state) {
      case LoadState.loading:
        _update(NavigationStatus.initializing);
        break;
      case LoadState.unauthorized:
        _update(NavigationStatus.unauthorized);
        break;
      case LoadState.update:
        _update(NavigationStatus.updateAvailable);
        break;
      case LoadState.succeed:
        _update(NavigationStatus.ready);
        break;
      default:
        _update(NavigationStatus.initializing);
    }
  }

  void updateFromAuthenticationState(AuthenticationState authenticationState) {
    if (authenticationState is AuthDoneState) {
      _update(NavigationStatus.ready);
    } else if ((authenticationState is AuthSigningInState ||
        authenticationState is AuthSigningUpState ||
        authenticationState is AuthStartState && state.status != NavigationStatus.authenticating)) {
      _update(NavigationStatus.authenticating);
    } else if (authenticationState is AuthStartState) {
      _update(NavigationStatus.unauthorized);
    }
  }

  void setPendingRoute(String path) {
    if (state.pendingRoute != null) return;
    if (state.pendingRoute == path) return;
    if (state.pendingRoute == Routes.authentication.path) return;
    if (state.pendingRoute == Routes.loader.path) return;
    if (state.pendingRoute == Routes.home.path) return;
    emit(state.copyWith(pendingRoute: path));
  }

  void clearPendingRoute() {
    emit(state.copyWith(setPendingToNull: true));
  }

  void _update(NavigationStatus status) {
    final oldStatus = state.status;
    emit(state.copyWith(status: status));
    if (oldStatus != status) {
      notifyListeners();
    }
  }
}
