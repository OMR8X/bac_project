import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/presentation/auth/state/bloc/auth_bloc.dart';
import 'package:bac_project/core/widgets/ui/icons/switch_theme_icon_widget.dart';
import 'package:bac_project/presentation/settings/widgets/setting_tile_widget.dart';
import 'package:bac_project/presentation/settings/widgets/settings_card_title_widget.dart';
import 'package:bac_project/presentation/settings/widgets/user_information_card_widget.dart';
import 'package:bac_project/presentation/root/blocs/theme/app_theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settingsTitle), actions: [SwitchThemeIconWidget()]),
      body: Padding(
        padding: Paddings.screenSidesPadding,
        child: SingleChildScrollView(
          padding: Paddings.listViewPadding,
          child: Column(
            children: [
              const SizedBox(height: SpacesResources.s10),

              const UserInformationCardWidget(),

              // Account Section
              SettingsCardTitleWidget(title: context.l10n.settingsAccountTitle),
              // Account Section Card
              Card(
                child: Column(
                  children: [
                    SettingTileWidget(
                      leadingIcon: Icon(
                        Icons.person_outline,
                        size: SizesResources.iconSettingsTileHeight,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      trailingIcon: Icons.chevron_right,
                      title: context.l10n.buttonsUpdateUserData,
                      onTap: () {
                        context.pushNamed(Routes.updateUserData.name);
                      },
                    ),
                    const Divider(height: 2),
                    SettingTileWidget(
                      leadingIcon: Icon(
                        Icons.lock_outline,
                        size: SizesResources.iconSettingsTileHeight,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      trailingIcon: Icons.chevron_right,
                      title: context.l10n.settingsUpdateMyPassword,
                      onTap: () {
                        context.pushNamed(Routes.updatePassword.name);
                      },
                    ),
                    const Divider(height: 2),
                    SettingTileWidget(
                      leadingIcon: Icon(
                        Icons.notifications_outlined,
                        size: SizesResources.iconSettingsTileHeight,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      trailingIcon: Icons.chevron_right,
                      title: context.l10n.settingsManageNotifications,
                      onTap: () {
                        context.pushNamed(Routes.notificationsTopics.name);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: SpacesResources.s2),

              // Preferences Section
              SettingsCardTitleWidget(title: context.l10n.settingsPreferencesTitle),
              Card(
                child: Column(
                  children: [
                    SettingTileWidget(
                      leadingIcon: Icon(
                        Icons.info_outline,
                        size: SizesResources.iconSettingsTileHeight,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      trailingIcon: Icons.chevron_right,
                      title: context.l10n.settingsAboutUs,
                      onTap: () {
                        context.pushNamed(Routes.aboutUs.name);
                      },
                    ),
                    const Divider(height: 2),
                    BlocBuilder<AppThemeBloc, AppThemeState>(
                      builder: (context, state) {
                        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
                        return SettingTileWidget(
                          leadingIcon: Image.asset(
                            isDarkMode
                                ? UIImagesResources.brightnessDarkUIIcon
                                : UIImagesResources.brightnessLightUIIcon,
                            width: SizesResources.iconSettingsTileHeight,
                            height: SizesResources.iconSettingsTileHeight,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          title:
                              isDarkMode
                                  ? context.l10n.settingsSwitchToLightTheme
                                  : context.l10n.settingsSwitchToDarkTheme,
                          onTap: () {
                            final bloc = context.read<AppThemeBloc>();
                            bloc.add(
                              ChangeAppThemeEvent(
                                isDarkMode ? AppThemes.lightTheme : AppThemes.darkTheme,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: SpacesResources.s2),

              // Support Section
              SettingsCardTitleWidget(title: context.l10n.settingsSupportTitle),
              Card(
                child: Column(
                  children: [
                    SettingTileWidget(
                      leadingIcon: Icon(
                        Icons.help_outline,
                        size: SizesResources.iconSettingsTileHeight,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      trailingIcon: Icons.chevron_right,
                      title: context.l10n.settingsHelpCenter,
                      onTap: () {
                        context.pushNamed(Routes.helpCenter.name);
                      },
                    ),
                    const Divider(height: 2),
                    SettingTileWidget(
                      leadingIcon: Icon(
                        Icons.contact_support_outlined,
                        size: SizesResources.iconSettingsTileHeight,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      trailingIcon: Icons.chevron_right,
                      title: context.l10n.settingsContactUs,
                      onTap: () {
                        context.pushNamed(Routes.contactUs.name);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: SpacesResources.s2),

              // Sign Out
              Card(
                child: SettingTileWidget(
                  leadingIcon: Icon(
                    Icons.logout_outlined,
                    size: SizesResources.iconSettingsTileHeight,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  trailingIcon: Icons.chevron_right,
                  title: context.l10n.buttonsSignOut,
                  onTap: () {
                    sl<AuthBloc>().add(const AuthSignOutEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
