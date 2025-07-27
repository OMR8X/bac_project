import 'package:bac_project/core/injector/app_injection.dart';

import 'package:bac_project/core/services/router/index.dart';

import 'package:bac_project/presentation/root/blocs/auth/auth_bloc.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

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
              if (state.failure != null) {
                Fluttertoast.showToast(msg: state.failure!.message);
              }
            },
            builder: (context, state) {
              if (state is AuthDoneState) {
                WidgetsBinding.instance.addPostFrameCallback((v) {
                  context.pushReplacement(AppRoutes.home.path);
                });
              }
              // if (state is AuthStartState) {
              //   return const AuthStartView();
              // } else if (state is AuthSigningUpState) {
              //   return SignUpView(state: state);
              // } else if (state is AuthSigningInState) {
              //   return SignInView(state: state);
              // }
              return const Center(child: CupertinoActivityIndicator());
            },
          ),
        ),
      ),
    );
  }
}
