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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsTitle),
        actions: [if (kDebugMode) SwitchThemeIconWidget()],
      ),
      body: Padding(
        padding: Paddings.screenSidesPadding,
        child: SingleChildScrollView(
          padding: Paddings.listViewPadding,
          child: Column(
            children: [
              const UserInformationCardWidget(),

              SizedBox(height: SpacesResources.s6),

              // Account Section
              SettingsCardTitleWidget(title: context.l10n.settingsAccountTitle),

              // Account Section Card
              Card(
                margin: Margins.cardMargin,
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
                    Divider(
                      height: 1,
                      thickness: 1,

                      indent: SizesResources.iconSettingsTileHeight * 2.5,
                      endIndent: SpacesResources.s16,
                    ),
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
                    Divider(
                      height: 1,
                      thickness: 1,

                      indent: SizesResources.iconSettingsTileHeight * 2.5,
                      endIndent: SpacesResources.s16,
                    ),
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

              SizedBox(height: SpacesResources.s6),

              // Preferences Section
              SettingsCardTitleWidget(title: context.l10n.settingsPreferencesTitle),
              Card(
                margin: Margins.cardMargin,
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
                    Divider(
                      height: 1,
                      thickness: 1,

                      indent: SizesResources.iconSettingsTileHeight * 2.5,
                      endIndent: SpacesResources.s16,
                    ),
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
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
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

              SizedBox(height: SpacesResources.s6),

              // Support Section
              SettingsCardTitleWidget(title: context.l10n.settingsSupportTitle),
              Card(
                margin: Margins.cardMargin,
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
                    Divider(
                      height: 1,
                      thickness: 1,

                      indent: SizesResources.iconSettingsTileHeight * 2.5,
                      endIndent: SpacesResources.s16,
                    ),
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

              SizedBox(height: SpacesResources.s6),

              // Sign Out
              Card(
                margin: Margins.cardMargin,
                child: SettingTileWidget(
                  leadingIcon: Icon(
                    Icons.logout_outlined,
                    size: SizesResources.iconSettingsTileHeight,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  // trailingIcon: Icons.chevron_right,
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
