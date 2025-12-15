import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:bac_project/presentation/root/blocs/theme/app_theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchThemeIconWidget extends StatelessWidget {
  const SwitchThemeIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppThemeBloc>();
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppBarIconWidget(
        icon: Image.asset(
          UIImagesResources.brightnessDarkUIIcon,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onPressed: () {
          bloc.add(const ChangeAppThemeEvent(AppThemes.lightTheme));
        },
      );
    } else {
      return AppBarIconWidget(
        icon: Image.asset(
          UIImagesResources.brightnessLightUIIcon,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onPressed: () {
          bloc.add(const ChangeAppThemeEvent(AppThemes.darkTheme));
        },
      );
    }
  }
}
