import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/features/settings/domain/entities/motivational_quote.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MotivationalQuoteView extends StatelessWidget {
  const MotivationalQuoteView({super.key, required this.quote});
  final MotivationalQuote quote;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.cardBorderRadius),
              margin: Margins.zero,

              child: Text("data"),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton.outlined(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusResource.bordersRadiusMedium,
                    ),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  icon: Image.asset(
                    UIImagesResources.closeUIIcon,
                    color: Colors.white,
                    width: 26,
                    height: 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
