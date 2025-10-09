import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:bac_project/presentation/root/blocs/theme/app_theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ArrowBackIconWidget extends StatelessWidget {
  const ArrowBackIconWidget({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBarIconWidget(
      icon: Image.asset(
        UIImagesResources.caretRightUIIcon,
        // color: Theme.of(context).colorScheme.onSurface,
        color: Color(0xff55534F),
      ),
      onPressed: onPressed ?? () => context.pop(),
    );
  }
}
