import 'package:bac_project/presentation/root/blocs/theme/app_theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchThemeWidget extends StatelessWidget {
  const SwitchThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppThemeBloc>();
    if (Theme.of(context).brightness == Brightness.dark) {
      return IconButton(
        onPressed: () {
          bloc.add(const ChangeAppThemeEvent(AppThemes.lightTheme));
        },
        icon: const Icon(Icons.light_mode, size: 20),
      );
    } else {
      return IconButton(
        onPressed: () {
          bloc.add(const ChangeAppThemeEvent(AppThemes.darkTheme));
        },
        icon: const Icon(Icons.dark_mode, size: 20),
      );
    }
  }
}
