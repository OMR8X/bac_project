import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/domain/entites/user_data.dart';

class UserInformationCardWidget extends StatelessWidget {
  const UserInformationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Margins.userInformationCardMargin,
      child: Padding(
        padding: Paddings.userInformationCardPadding,
        child: ListTile(
          leading: _buildAvatar(context),
          title: Text(sl<UserData>().name, style: TextStylesResources.cardLargeTitle),
          subtitle: Text(sl<UserData>().email, style: TextStylesResources.cardMediumSubtitle),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacesResources.s6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadiusResource.tileBoxBorderRadius,
      ),
      child: Icon(
        Icons.person,
        color: Theme.of(context).colorScheme.onSurface,
        size: 28,
      ),
    );
  }
}
