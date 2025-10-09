import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/logs/logger.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/core/widgets/messages/snackbars/error_snackbar_widget.dart';
import 'package:bac_project/presentation/auth/state/bloc/auth_bloc.dart';
import 'package:bac_project/presentation/auth/view/auth_start_view.dart';
import 'package:bac_project/presentation/auth/view/sign_in_view.dart';
import 'package:bac_project/presentation/auth/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/resources/styles/spacing_resources.dart';
import '../../../core/widgets/messages/snackbars/success_snackbar_widget.dart';
import '../../root/blocs/navigation/navigation_cubit.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocProvider.value(
          value: sl<AuthBloc>(),
          child: BlocConsumer<AuthBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthDoneState) {
                sl<NavigationCubit>().updateFromAuthenticationState(state);
              }
              if (state.failure != null) {
                showErrorSnackbar(context: context, title: state.failure!.message);
                return;
              }
              if (state.successMessage != null) {
                showSuccessSnackbar(context: context, title: state.successMessage!);
                return;
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
                return const _AuthLoadingWidget();
              } else if (state is AuthDoneState) {
                return const _AuthLoadingWidget(); // Show loading while transitioning
              }
              return const AuthStartView(); // Default fallback
            },
          ),
        ),
      ),
    );
  }
}

class _AuthLoadingWidget extends StatelessWidget {
  const _AuthLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: Paddings.screenBodyPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CupertinoActivityIndicator()],
          ),
        ),
      ),
    );
  }
}
