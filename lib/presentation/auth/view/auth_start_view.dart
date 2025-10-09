import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/presentation/auth/state/bloc/auth_bloc.dart';
import 'package:bac_project/core/widgets/ui/icons/switch_theme_icon_widget.dart';
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
      appBar: AppBar(actions: [SwitchThemeIconWidget()]),
      body: SafeArea(
        child: Padding(
          padding: Paddings.screenSidesPadding,
          child: Column(
            children: [
              const Spacer(),
              StaggeredItemWrapperWidget(
                position: 0,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                  ),
                  child: Text(context.l10n.buttonsSignIn),
                  onPressed: () {
                    sl<AuthBloc>().add(const AuthStartSignInEvent());
                  },
                ),
              ),
              const SizedBox(height: SpacesResources.s5),
              StaggeredItemWrapperWidget(
                position: 0,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                  ),
                  child: Text(context.l10n.buttonsSignUp),
                  onPressed: () {
                    sl<AuthBloc>().add(const AuthStartSignUpEvent());
                  },
                ),
              ),
              const SizedBox(height: SpacesResources.s20),
            ],
          ),
        ),
      ),
    );
  }
}
