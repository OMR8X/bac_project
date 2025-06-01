import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/fields/elevated_button_widget.dart';
import 'package:bac_project/presentation/root/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';

class AuthStartView extends StatefulWidget {
  const AuthStartView({super.key});

  @override
  State<AuthStartView> createState() => _AuthStartViewState();
}

class _AuthStartViewState extends State<AuthStartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            StaggeredItemWrapperWidget(
              position: 0,
              child: ElevatedButtonWidget(
                title: LocalizationManager().get(LocalizationKeys.auth.signIn),
                onPressed: () {
                  sl<AuthBloc>().add(const AuthStartSignInEvent());
                },
              ),
            ),
            StaggeredItemWrapperWidget(
              position: 0,
              child: ElevatedButtonWidget(
                title: LocalizationManager().get(LocalizationKeys.auth.signUp),
                onPressed: () {
                  sl<AuthBloc>().add(const AuthStartSignUpEvent());
                },
                backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainerHigh,
              ),
            ),
            const SizedBox(height: SpacesResources.s20),
          ],
        ),
      ),
    );
  }
}
