import 'dart:ui';

import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/blur_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class PagesHolderView extends StatefulWidget {
  const PagesHolderView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<PagesHolderView> createState() => _PagesHolderViewState();
}

class _PagesHolderViewState extends State<PagesHolderView> {
  void _changePage(int pageIndex) {
    widget.navigationShell.goBranch(pageIndex);
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            widget.navigationShell,
            Align(
              alignment: Alignment.bottomCenter,
              child: _NavigationBar(widget.navigationShell.currentIndex, _changePage),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _NavigationBar(widget.navigationShell.currentIndex, _changePage),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar(this.currentIndex, this.changePage);
  final int currentIndex;
  final void Function(int pageIndex) changePage;
  @override
  Widget build(BuildContext context) {
    //
    return ClipRect(
      child: BackdropFilter(
        filter: BlurResources.bottomNavigationBarBlur(context),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
            ),
            color: Theme.of(context).colorScheme.surface.withAlpha(150),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + SpacesResources.s1,
              top: SpacesResources.s6,
              left: Paddings.screenSidesPadding.left,
              right: Paddings.screenSidesPadding.right,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: BottomNavTab(
                    selectedIconPath: UIImagesResources.homeIconFilled,
                    unselectedIconPath: UIImagesResources.homeIconOutline,
                    label: context.l10n.navigationHome,
                    selected: currentIndex == 0,
                    onTap: () => changePage(0),
                  ),
                ),
                Expanded(
                  child: BottomNavTab(
                    selectedIconPath: UIImagesResources.resultsIconFilled,
                    unselectedIconPath: UIImagesResources.resultsIconOutline,
                    label: context.l10n.navigationResults,
                    selected: currentIndex == 1,
                    onTap: () => changePage(1),
                  ),
                ),
                Expanded(
                  child: BottomNavTab(
                    selectedIconPath: UIImagesResources.settingsIconFilled,
                    unselectedIconPath: UIImagesResources.settingsIconOutline,
                    label: context.l10n.navigationSettings,
                    selected: currentIndex == 2,
                    onTap: () => changePage(2),
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

class BottomNavTab extends StatelessWidget {
  final String selectedIconPath;
  final String unselectedIconPath;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const BottomNavTab({
    super.key,
    required this.selectedIconPath,
    required this.unselectedIconPath,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        selected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: SvgPicture.asset(
                selected ? selectedIconPath : unselectedIconPath,
                key: ValueKey(selected),
                width: 18,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
            ),

            const SizedBox(height: SpacesResources.s4),
            Text(label, style: TextStylesResources.bottomNavigationBarLabel.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
