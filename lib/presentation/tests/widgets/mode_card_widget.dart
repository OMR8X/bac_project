import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/shadows_resources.dart';

import 'package:flutter/material.dart';
import '../../../core/resources/styles/border_radius_resources.dart';
import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/resources/styles/spaces_resources.dart';

class ModeCardWidget extends StatelessWidget {
  const ModeCardWidget({
    super.key,
    required this.onTap,
    this.isSelected = false,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    this.imageColor,
  });

  final VoidCallback onTap;
  final bool isSelected;
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;
  final Color? imageColor;

  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const double _iconSize = 44.0;
  static const double _iconContainerSize = 60.0; // 44 + 8*2 padding

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: PaddingResources.cardLargeInnerPadding,
        margin: PaddingResources.cardOuterPadding,
        decoration: _buildCardDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(context), _buildExpandableDescription(context)],
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer,
      border: Border.all(
        color:
            isSelected
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : Theme.of(context).colorScheme.outline,
        width: 0.75,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadiusResource.cardBorderRadius,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconContainer(context),
        const SizedBox(width: SpacesResources.s12),
        _buildTextContent(context),
        _buildSelectionIndicator(context, isSelected),
      ],
    );
  }

  Widget _buildIconContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        border: Border.all(color: Theme.of(context).colorScheme.outline, width: 0.75),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        imagePath,
        width: _iconSize,
        height: _iconSize,
        colorBlendMode: BlendMode.srcIn,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: SpacesResources.s3),
          _buildTitle(context),
          const SizedBox(height: SpacesResources.s4),
          _buildSubtitle(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,

        height: 1.2,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      subtitle,
      style: AppTextStyles.cardSmallSubtitle.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: 0.1,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSelectionIndicator(BuildContext context, bool isSelected) {
    return Radio(value: isSelected, groupValue: true, onChanged: (value) {});
  }

  Widget _buildExpandableDescription(BuildContext context) {
    return AnimatedSize(
      duration: _animationDuration,
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: _animationDuration,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: _buildTransition,
        layoutBuilder: _buildLayout,
        child: isSelected ? _buildDescription(context) : _buildEmptySpace(),
      ),
    );
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -0.2),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  Widget _buildLayout(Widget? currentChild, List<Widget> previousChildren) {
    return currentChild ?? const SizedBox.shrink();
  }

  Widget _buildDescription(BuildContext context) {
    return Container(
      key: const ValueKey(true),
      margin: EdgeInsets.only(
        top: SpacesResources.s8,
        left: _iconContainerSize + SpacesResources.s12,
      ),
      child: _buildDescriptionText(context),
    );
  }

  Widget _buildEmptySpace() {
    return const SizedBox.shrink(key: ValueKey(false));
  }

  Widget _buildDescriptionText(BuildContext context) {
    return Text(
      description,
      style: AppTextStyles.cardSmallSubtitle.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        height: 1.4,
      ),
    );
  }
}
