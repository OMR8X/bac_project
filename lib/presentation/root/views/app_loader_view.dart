import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/presentation/root/blocs/loader/app_loader_bloc.dart';
import 'package:bac_project/presentation/root/views/app_available_update_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/injector/app_injection.dart';
import '../../../core/services/router/app_routes.dart';
import '../../notifications/state/explore_notifications/notifications_bloc.dart';

class AppLoaderView extends StatefulWidget {
  const AppLoaderView({super.key});

  @override
  State<AppLoaderView> createState() => _AppLoaderViewState();
}

class _AppLoaderViewState extends State<AppLoaderView> {
  onSucceed() {
    sl<NotificationsBloc>().add(StoreTokenEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(AppRoutes.home.path);
    });
  }

  onUnAuthorized() {
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
              onSucceed();
            } else if (state.state == LoadState.unauthorized) {
              onUnAuthorized();
            } else if (state.state == LoadState.failure) {
              return Center(child: Text(state.failure!.message));
            } else if (state.state == LoadState.update) {
              return AppAvailableUpdateView(
                version: state.version,
                onUpdate: () {},
                onSkip: onSucceed,
              );
            }
            return SafeArea(
              child: Padding(
                padding: Paddings.splashScreenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    StaggeredItemWrapperWidget(
                      position: 1,
                      child: Image.asset(
                        'assets/images/logo/neuro-icon.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    SizedBox(height: SpacesResources.s40),
                    StaggeredItemWrapperWidget(
                      position: 2,
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                          strokeCap: StrokeCap.round,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                    const Spacer(),
                    StaggeredItemWrapperWidget(
                      position: 3,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'نيورو',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SpacesResources.s4),
                          Text(
                            '© ${DateTime.now().year} جميع الحقوق محفوظة',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
