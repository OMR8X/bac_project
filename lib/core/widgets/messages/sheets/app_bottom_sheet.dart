import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';

showAppBottomSheet({
  required BuildContext context,
  required Widget child,
  String? title,
  List<Widget>? actions,
  bool showDragHandle = true,
}) {
  showModalBottomSheet(
    context: context,
    showDragHandle: showDragHandle,
    enableDrag: true,
    useSafeArea: true,
    // backgroundColor: Colors.transparent,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.8, // 90% of screen height
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (context) => Padding(
          padding: Paddings.modalBottomSheetPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // // indicator
              // Container(
              //   margin: const EdgeInsets.only(top: 12),
              //   height: 4,
              //   width: 40,
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.outline,
              //     borderRadius: BorderRadius.circular(2),
              //   ),
              // ),

              // Header
              // Padding(
              //   padding: Paddings.cardMediumPadding.copyWith(bottom: 0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child:
              //             title != null
              //                 ? Text(
              //                   title,
              //                   style: TextStylesResources.dialogTitle.copyWith(
              //                     // color: Theme.of(context).colorScheme.onSurfaceVariant,
              //                   ),
              //                 )
              //                 : const SizedBox.shrink(),
              //       ),
              //       // IconButton(
              //       //   onPressed: () => Navigator.of(context).pop(),
              //       //   icon: const Icon(Icons.close),
              //       //   style: IconButton.styleFrom(
              //       //     padding: EdgeInsets.zero,
              //       //     minimumSize: const Size(32, 32),
              //       //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //       //   ),
              //       // ),
              //       AppBarIconWidget(
              //         icon: Icon(Icons.close, size: SizesResources.iconAppBarHeight),
              //         onPressed: () => Navigator.of(context).pop(),
              //       ),
              //     ],
              //   ),
              // ),

              // Content
              Flexible(
                child: Padding(
                  padding: Paddings.cardMediumPadding.copyWith(top: SpacesResources.s4),
                  child: child,
                ),
              ),

              // Actions/buttons section
              if (actions != null && actions.isNotEmpty)
                Padding(
                  padding: Paddings.bottomSheetActionsPadding,
                  child: Column(
                    children: [
                      ...actions.map(
                        (action) => Padding(
                          padding: EdgeInsets.only(bottom: SpacesResources.s3),
                          child: action,
                        ),
                      ),
                    ],
                  ),
                ),

              // Bottom safe area padding
              SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? 0 : 16),
            ],
          ),
        ),
  );
}
