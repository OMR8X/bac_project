
import 'dart:ui';

import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/features/settings/domain/entities/motivational_quote.dart';
import 'package:dartz/dartz_streaming.dart' hide Text;
import 'package:flutter/material.dart';

class QuoteOfTheDayWidget extends StatelessWidget {
  final MotivationalQuote quote;

  const QuoteOfTheDayWidget({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "اقتباس اليوم: ${quote.quote}, من ${quote.author}",
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.bordersRadiusMedium),
        margin: PaddingResources.quoteOfTheDayCardOuterPadding,
        child: Padding(
          padding: PaddingResources.cardMediumInnerPadding,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: PaddingResources.quoteOfTheDayCardInnerPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: SpacesResources.s4,
                    children: [
                      // Quote label (optional)
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: SpacesResources.s2,
                          horizontal: SpacesResources.s3,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
                          borderRadius: BorderRadiusResource.bordersRadiusSmall,
                        ),
                        child: Text(
                          "اقتباس اليوم",
                          style: AppTextStyles.caption.copyWith(
                            color: Theme.of(context).colorScheme.surface,
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
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                            size: 20,
                          ),
                          SizedBox(width: SpacesResources.s2),
                          Expanded(
                            child: Text(
                              quote.quote,
                              style: AppTextStyles.cardMediumTitle.copyWith(
                                color: Theme.of(context).colorScheme.surface,
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
                        padding: EdgeInsets.only(right: SpacesResources.s6),
                        child: Text(
                          "— ${quote.author}",
                          style: AppTextStyles.caption.copyWith(
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                            fontSize: FontSizeResources.s11,
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
    );
  }
}
