import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:flutter/material.dart';
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
      body: SizedBox(width: double.infinity, height: double.infinity, child: widget.navigationShell),
      bottomNavigationBar: _NavigationBar(widget.navigationShell.currentIndex, _changePage),
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
    final activeColor = Theme.of(context).colorScheme.primary;
    final unActiveColor = Theme.of(context).colorScheme.onPrimary;
    //
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + SpacesResources.s4, top: SpacesResources.s10),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// home view
          Expanded(
            child: GestureDetector(
              onTap: () {
                changePage(0);
              },
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: currentIndex == 0 ? activeColor : unActiveColor, borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Image.asset(color: currentIndex == 0 ? unActiveColor : activeColor, UIImagesResources.homeIcon, width: 15),
                    ),
                    //
                    const SizedBox(height: SpacesResources.s6),
                    //
                    Text(sl<LocalizationManager>().get(LocalizationKeys.bottomNavigationBar.home)),
                  ],
                ),
              ),
            ),
          ),

          /// designing view
          Expanded(
            child: GestureDetector(
              onTap: () {
                changePage(1);
              },
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: currentIndex == 1 ? activeColor : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Image.asset(color: currentIndex == 1 ? unActiveColor : activeColor, UIImagesResources.uploadingIcon, width: 15),
                    ),
                    //
                    const SizedBox(height: SpacesResources.s6),
                    //
                    Text(sl<LocalizationManager>().get(LocalizationKeys.bottomNavigationBar.results)),
                  ],
                ),
              ),
            ),
          ),

          /// home view
          Expanded(
            child: GestureDetector(
              onTap: () {
                changePage(2);
              },
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: currentIndex == 2 ? activeColor : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Image.asset(color: currentIndex == 2 ? unActiveColor : activeColor, UIImagesResources.listIcon, width: 15),
                    ),
                    //
                    const SizedBox(height: SpacesResources.s6),
                    //
                    Text(sl<LocalizationManager>().get(LocalizationKeys.bottomNavigationBar.settings)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
