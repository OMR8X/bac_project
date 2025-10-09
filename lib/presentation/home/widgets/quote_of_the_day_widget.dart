import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/features/settings/domain/entities/motivational_quote.dart';
import 'package:flutter/material.dart';

class QuoteOfTheDayWidget extends StatelessWidget {
  final MotivationalQuote quote;

  const QuoteOfTheDayWidget({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "اقتباس اليوم: ${quote.quote}, من ${quote.author}",
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        // color: Theme.of(context).colorScheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusResource.bordersRadiusMedium,
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.5,
          ),
        ),
        margin: Margins.quoteOfTheDayCardMargin,
        key: Key(quote.quote),
        child: InkWell(
          child: Padding(
            padding: Paddings.customPadding(2, 6),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: Paddings.quoteOfTheDayCardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: SpacesResources.s4,
                      children: [
                        // Quote label (optional)
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: SpacesResources.s3,
                            horizontal: SpacesResources.s4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadiusResource.bordersRadiusXTiny,
                          ),
                          child: Text(
                            "اقتباس اليوم",
                            style: TextStylesResources.caption.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: FontSizeResources.s10,
                              fontWeight: FontWeightResources.medium,
                            ),
                          ),
                        ),

                        // Quote icon
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.format_quote,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              size: 20,
                            ),
                            SizedBox(width: SpacesResources.s2),
                            Expanded(
                              child: Text(
                                quote.quote,
                                style: TextStylesResources.cardMediumTitle.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  fontSize: FontSizeResources.s16,
                                  fontWeight: FontWeightResources.bold,
                                  height: 1.6,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Author attribution
                        Padding(
                          padding: EdgeInsets.only(right: SpacesResources.s2),
                          child: Text(
                            "- ${quote.author}",
                            style: TextStylesResources.caption.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer.withOpacity(0.8),
                              fontSize: FontSizeResources.s9,
                              fontWeight: FontWeightResources.medium,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
