import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/presentation/root/blocs/loader/app_loader_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/injector/app_injection.dart';
import '../../../core/services/router/app_routes.dart';

class AppLoaderView extends StatefulWidget {
  const AppLoaderView({super.key});

  @override
  State<AppLoaderView> createState() => _AppLoaderViewState();
}

class _AppLoaderViewState extends State<AppLoaderView> {
  @override
  void initState() {
    super.initState();
    sl<AppLoaderBloc>().add(const AppLoaderLoadData());
  }

  onDone() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(AppRoutes.authViewsManager.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: sl<AppLoaderBloc>(),
        child: BlocBuilder<AppLoaderBloc, AppLoaderState>(
          builder: (context, state) {
            if (state.state == LoadState.succeed) {
              onDone();
              // if (state.version.updateAvailable) {
              //   return AppAvailableUpdateView(version: state.version, onUpdate: () {}, onSkip: onDone);
              // } else {
              //   onDone();
              // }
            }
            if (state.state == LoadState.failure) {
              return Center(child: Text(state.failure!.message));
            }
            return const Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
    );
  }
}
