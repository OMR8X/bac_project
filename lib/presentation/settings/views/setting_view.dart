import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/core/widgets/ui/fields/mode_switcher_widget.dart';
import 'package:bac_project/presentation/auth/state/bloc/auth_bloc.dart';
import 'package:bac_project/core/widgets/ui/icons/switch_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settingsTitle), actions: [SwitchThemeWidget()]),
      body: Padding(
        padding: PaddingResources.screenSidesPadding,
        child: Column(
          children: [
            const SizedBox(height: SpacesResources.s10),
            Card(
              child: ListTile(
                title: Text(context.l10n.buttonsUpdateUserData),
                onTap: () {
                  context.pushNamed(AppRoutes.updateUserData.name);
                },
              ),
            ),

            const SizedBox(height: SpacesResources.s2),
            Card(
              child: ListTile(
                title: Text(context.l10n.buttonsSignOut),
                onTap: () {
                  sl<AuthBloc>().add(const AuthSignOutEvent());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
