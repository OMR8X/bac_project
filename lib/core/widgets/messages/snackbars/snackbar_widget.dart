import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../resources/styles/blur_resources.dart';

class SnackbarWidget {
  final String title;
  final String? subtitle;
  final Color backgroundColor;
  final IconData? icon;

  final Duration duration;
  final BuildContext context;

  const SnackbarWidget({
    required this.context,
    required this.title,
    this.subtitle,
    required this.backgroundColor,

    this.icon,
    this.duration = const Duration(seconds: 3),
  });

  SnackBar call() {
    HapticFeedback.lightImpact();
    return SnackBar(
      duration: duration,
      backgroundColor: Colors.transparent,
      margin: Margins.zero,
      padding: Paddings.zero,
      elevation: 0.0,
      content: AnimationConfiguration.staggeredList(
        position: 1,
        duration: const Duration(milliseconds: 120),
        child: SlideAnimation(
          verticalOffset: 100,
          child: ScaleAnimation(
            scale: 0.8,
            child: FadeInAnimation(
              curve: Curves.easeOut,
              child: ClipRect(
                child: BackdropFilter(
                  filter: BlurResources.snackbarBlur(context),
                  child: Container(
                    margin: Margins.snackbarMargin,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusResource.snackbarBorderRadius,
                      color: _backgroundColor,
                    ),
                    child: Padding(
                      padding: Paddings.cardSmallPadding,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _iconContainerColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              icon ?? Icons.notifications_outlined,
                              color: Theme.of(context).colorScheme.onSurface,
                              size: 24,
                            ),
                          ),

                          ///
                          const SizedBox(width: 12),

                          /// Title and subtitle
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBoxes.s2v,
                                Text(
                                  title,
                                  style: TextStylesResources.cardMediumTitle.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                if (subtitle != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    subtitle!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStylesResources.cardSmallSubtitle.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                                SizedBoxes.s4v,
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Close icon with transparent background
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: duration,
                            builder: (context, value, child) {
                              return IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                },
                                icon: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: CircularProgressIndicator(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface.withAlpha(150),
                                        value: value,

                                        strokeCap: StrokeCap.round,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    Icon(
                                      Icons.close,
                                      color: Theme.of(context).colorScheme.surface.withAlpha(150),
                                      size: 16,
                                    ),
                                  ],
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(color: Colors.transparent),
                                  padding: const EdgeInsets.all(4),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );
  }

  Color get _backgroundColor {
    if (Theme.of(context).brightness == Brightness.light) {
      return backgroundColor.lighter(0.5).withAlpha(220);
    }
    return backgroundColor.darker(0.2).withAlpha(220);
  }

  Color get _iconContainerColor {
    if (Theme.of(context).brightness == Brightness.light) {
      return backgroundColor.lighter(0.75);
    }
    return backgroundColor.darker(0.5);
  }
}
