import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/presentation/root/blocs/loader/app_loader_bloc.dart';
import 'package:bac_project/presentation/root/views/app_available_update_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/build_context_l10n.dart';
import '../../../core/injector/app_injection.dart';
import '../blocs/navigation/navigation_cubit.dart';

class AppLoaderView extends StatefulWidget {
  const AppLoaderView({super.key});

  @override
  State<AppLoaderView> createState() => _AppLoaderViewState();
}

class _AppLoaderViewState extends State<AppLoaderView> {
  bool didNavigate = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<AppLoaderBloc>().add(const AppLoaderLoadData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: sl<AppLoaderBloc>(),
        child: BlocConsumer<AppLoaderBloc, AppLoaderState>(
          buildWhen: (previous, current) => previous.state != current.state,
          listener: (context, state) {
            sl<NavigationCubit>().updateFromLoader(state);
          },
          builder: (context, state) {
            if (state.state == LoadState.failure) {
              return ErrorStateBodyWidget(
                title: context.l10n.errorLoadingApp,
                failure: state.failure,
                onRetry: () => sl<AppLoaderBloc>().add(const AppLoaderLoadData()),
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
