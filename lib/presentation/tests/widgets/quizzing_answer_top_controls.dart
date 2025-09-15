import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:flutter/material.dart';

class QuizzingAnswerTopControls extends StatelessWidget {
  const QuizzingAnswerTopControls({
    super.key,
    required this.timeLeft,
    required this.current,
    required this.total,
    required this.onClose,
  });

  final Duration timeLeft;
  final int current;
  final int total;
  final VoidCallback onClose;

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String _pad2(int value) => value.toString().padLeft(2, '0');

  String _formatQuestionCount(int current, int total) => '${_pad2(total)}/${_pad2(current)}';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: SizesResources.iconButtonAppBarHeight,
          width: SizesResources.iconButtonAppBarHeight,
          child: IconButton(
            onPressed: onClose,
            icon: Image.asset(
              UIImagesResources.closeUIIcon,
              width: SizesResources.iconAppBarHeight,
              height: SizesResources.iconAppBarHeight,
            ),
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.outline, width: 0.5),
                borderRadius: BorderRadiusResource.buttonBorderRadius,
              ),
            ),
          ),
        ),
        Container(
          height: SizesResources.iconButtonAppBarHeight,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline, width: 0.5),
            borderRadius: BorderRadiusResource.buttonBorderRadius,
          ),
          margin: EdgeInsets.only(
            right: TextStylesResources.cardMediumTitle.fontSize!.toDouble() + 10,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatDuration(timeLeft),
                style: TextStylesResources.cardMediumTitle.copyWith(
                  fontWeight: FontWeightResources.regular,
                ),
              ),
              const SizedBox(width: SpacesResources.s4),
              Icon(
                Icons.timer,
                size: TextStylesResources.cardMediumTitle.fontSize,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),

        Container(
          height: SizesResources.iconButtonAppBarHeight,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline, width: 0.5),
            borderRadius: BorderRadiusResource.buttonBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Text(
              _formatQuestionCount(current, total),
              style: TextStylesResources.cardMediumTitle.copyWith(
                fontWeight: FontWeightResources.regular,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
