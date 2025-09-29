import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/core/widgets/messages/snackbars/error_snackbar_widget.dart';
import 'package:bac_project/core/widgets/ui/states/loading_state_body_widget.dart';
import 'package:bac_project/presentation/auth/state/bloc/auth_bloc.dart';
import 'package:bac_project/presentation/auth/view/auth_start_view.dart';
import 'package:bac_project/presentation/auth/view/sign_in_view.dart';
import 'package:bac_project/presentation/auth/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/messages/snackbars/success_snackbar_widget.dart';

class AuthViewsManager extends StatefulWidget {
  const AuthViewsManager({super.key});

  @override
  State<AuthViewsManager> createState() => _AuthViewsManagerState();
}

class _AuthViewsManagerState extends State<AuthViewsManager> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocProvider.value(
          value: sl<AuthBloc>(),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthDoneState) {
                WidgetsBinding.instance.addPostFrameCallback((v) {
                  context.pushReplacement(AppRoutes.home.path);
                });
              }
              if (state.failure != null) {
                showErrorSnackbar(context: context, title: state.failure!.message);
              }
              if (state.successMessage != null) {
                showSuccessSnackbar(context: context, title: state.successMessage!);
              }
            },
            builder: (context, state) {
              if (state is AuthStartState) {
                return const AuthStartView();
              } else if (state is AuthSigningUpState) {
                return SignUpView(state: state);
              } else if (state is AuthSigningInState) {
                return SignInView(state: state);
              } else if (state is AuthLoadingState) {
                return const LoadingStateBodyWidget();
              } else if (state is AuthDoneState) {
                return const LoadingStateBodyWidget(); // Show loading while transitioning
              }
              return const AuthStartView(); // Default fallback
            },
          ),
        ),
      ),
    );
  }
}
