import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:flutter/material.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:go_router/go_router.dart';

class ResultCardWidget extends StatefulWidget {
  final Result result;
  final VoidCallback onExplore;
  const ResultCardWidget({super.key, required this.result, required this.onExplore});

  @override
  State<ResultCardWidget> createState() => _ResultCardWidgetState();
}

class _ResultCardWidgetState extends State<ResultCardWidget> {
  final GlobalKey menuKey = GlobalKey();

  late final PopupMenuItem<int> editWidget;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      editWidget = buildMenuItem(
        context: context,
        label: "اعادة الاختبار",
        icon: Icons.refresh,
        iconColor: Theme.of(context).colorScheme.primary,
        onTap: () {
          context.push(
            AppRoutes.fetchCustomQuestions.path,
            extra: FetchCustomQuestionsArguments(resultId: widget.result.id),
          );
        },
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int percent = widget.result.score.round();
    final Color scoreColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Card(
      margin: Margins.cardMargin,
      child: InkWell(
        borderRadius: BorderRadiusResource.cardBorderRadius,
        onTap: widget.onExplore,
        child: Padding(
          padding: Paddings.cardMediumPadding,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildIconBox(context),
                const SizedBox(width: SpacesResources.s6),
                Expanded(child: _buildMainInfo(context, percent, scoreColor)),
                const SizedBox(width: SpacesResources.s6),
                IconButton(
                  key: menuKey,
                  onPressed: () {
                    //
                    final RenderBox renderBox =
                        menuKey.currentContext!.findRenderObject() as RenderBox;
                    final Offset offset = renderBox.localToGlobal(
                      Offset.zero,
                    ); // Get the position of the button
                    final Size size = renderBox.size; // Get the size of the button
                    //
                    RelativeRect position = RelativeRect.fromLTRB(
                      offset.dx,
                      offset.dy + size.height,
                      offset.dx + size.width,
                      offset.dy,
                    );
                    //
                    late List<PopupMenuEntry<int>> items;
                    //
                    items = [editWidget];
                    //
                    showMenu(
                      context: context,
                      position: position,
                      menuPadding: Paddings.zero,
                      items: items,
                    );
                  },

                  icon: Image.asset(
                    UIImagesResources.threeDotsVerticalUIIcon,
                    height: SizesResources.iconCardHeight,
                  ),
                  style: IconButton.styleFrom(
                    side: BorderSide(color: Colors.transparent),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<int> buildMenuItem({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color iconColor,
    required void Function()? onTap,
  }) {
    return PopupMenuItem(
      onTap: onTap,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Icon(icon, size: 14)],
      ),
    );
  }

  Widget _buildIconBox(BuildContext context) {
    final int percent = widget.result.score.round();
    final Color backgroundColor = _getScoreBackgroundColor(context, percent);
    final Color textColor = _getScoreTextColor(context, percent);

    return Container(
      width: 50,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadiusResource.tileBoxBorderRadius,
      ),
      child: Center(
        child: Text(
          '${percent.clamp(0, 100)}%'.replaceAll('.0', ''),
          style: TextStylesResources.cardSmallTitle.copyWith(
            fontSize: FontSizeResources.s11,
            color: textColor,
            fontWeight: FontWeightResources.bold,
          ),
        ),
      ),
    );
  }

  Color _getScoreBackgroundColor(BuildContext context, int score) {
    if (score > 50) {
      if (score >= 85) {
        return Theme.of(context).extension<ExtraColors>()!.green.withAlpha(20);
      } else {
        return Theme.of(context).extension<ExtraColors>()!.orange.withAlpha(20);
      }
    } else {
      return Theme.of(context).extension<ExtraColors>()!.red.withAlpha(20);
    }
  }

  Color _getScoreTextColor(BuildContext context, int score) {
    if (score > 50) {
      if (score >= 85) {
        return Theme.of(context).extension<ExtraColors>()!.green.darker(0.3);
      } else {
        return Theme.of(context).extension<ExtraColors>()!.orange.darker(0.3);
      }
    } else {
      return Theme.of(context).extension<ExtraColors>()!.red.darker(0.3);
    }
  }

  Widget _buildMainInfo(BuildContext context, int percent, Color scoreColor) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'عنوان الدرس',
          style: TextStylesResources.caption.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeightResources.bold,
            fontSize: FontSizeResources.s10,
          ),
        ),
        const SizedBox(height: SpacesResources.s2),
        Text(
          widget.result.lessonTitle ?? 'اختبار مخصص',
          style: TextStylesResources.cardMediumTitle.copyWith(color: theme.colorScheme.onSurface),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: SpacesResources.s3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              UIImagesResources.calendarBlankUIIcon,
              height: FontSizeResources.s12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: SpacesResources.s2),
            Text(
              widget.result.createdAt.toLocal().toIso8601String().split('T').first,
              style: TextStylesResources.caption.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        // Bottom stat row removed (compact design)
      ],
    );
  }
}

// class _ActionMenuWidget extends StatefulWidget {
//   const _ActionMenuWidget({required this.result, required this.onDelete, required this.onEdit});
//   final Result result;
//   final VoidCallback onDelete;
//   final VoidCallback onEdit;
//   @override
//   State<_ActionMenuWidget> createState() => _ActionMenuWidgetState();
// }

// class _ActionMenuWidgetState extends State<_ActionMenuWidget> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((t) {});
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(key: _menuKey, icon: Icon(Icons.more_vert, size: 20), onPressed: () {});
//   }
// }
