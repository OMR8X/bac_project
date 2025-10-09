import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/shadows_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

class MotivationalQuoteCardWidget extends StatelessWidget {
  final String quote;
  final String author;
  final IconData icon;
  final VoidCallback onTap;

  const MotivationalQuoteCardWidget({
    super.key,
    required this.quote,
    required this.author,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Margins.quoteOfTheDayCardMargin,
      elevation: 0,

      child: InkWell(
        borderRadius: BorderRadiusResource.cardBorderRadius,
        onTap: onTap,
        child: Container(
          padding: Paddings.quoteOfTheDayCardPadding,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadiusResource.cardBorderRadius,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconSection(context),
              const SizedBox(width: SpacesResources.s6),
              Expanded(child: _buildContentSection(context)),
              const SizedBox(width: SpacesResources.s2),
              Icon(
                Icons.keyboard_arrow_left,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacesResources.s4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadiusResource.iconBorderRadius,
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "sl<LocalizationManager>().get(LocalizationKeys.home.quote.dailyQuote)",
          style: TextStylesResources.cardMediumTitle.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeightResources.bold,
          ),
        ),
        const SizedBox(height: SpacesResources.s3),
        Text(
          quote,
          style: TextStylesResources.cardMediumSubtitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            height: 1.4,
            fontSize: FontSizeResources.s13,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: SpacesResources.s2),
        Text(
          '- $author',
          style: TextStylesResources.cardSmallSubtitle.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontStyle: FontStyle.italic,
            fontSize: FontSizeResources.s11,
          ),
        ),
      ],
    );
  }
}
