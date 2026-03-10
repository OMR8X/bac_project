import 'package:neuro_app/core/extensions/build_context_l10n.dart';
import 'package:neuro_app/core/resources/styles/assets_resources.dart';
import 'package:neuro_app/core/resources/styles/blur_resources.dart';
import 'package:neuro_app/core/resources/styles/font_styles_manager.dart';
import 'package:neuro_app/core/resources/styles/spacing_resources.dart';
import 'package:neuro_app/core/resources/styles/spaces_resources.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/router/app_arguments.dart';
import '../../../../core/services/router/routes.dart';

import '../../../../features/tests/domain/entities/lesson.dart';

// Subject Data Imports
import '../../../../features/subjects/data/analysis/subject.dart';
import '../../../../features/subjects/data/analysis/lessons.dart';
import '../../../../features/subjects/data/arabic/subject.dart';
import '../../../../features/subjects/data/arabic/lessons.dart';
import '../../../../features/subjects/data/chemistry/subject.dart';
import '../../../../features/subjects/data/chemistry/lessons.dart';
import '../../../../features/subjects/data/english/subject.dart';
import '../../../../features/subjects/data/english/lessons.dart';
import '../../../../features/subjects/data/french/materaill.dart';
import '../../../../features/subjects/data/french/lessons.dart';
import '../../../../features/subjects/data/geography/subject.dart';
import '../../../../features/subjects/data/geography/lessons.dart';
import '../../../../features/subjects/data/history/subject.dart';
import '../../../../features/subjects/data/history/lessons.dart';
import '../../../../features/subjects/data/patriotism/subject.dart';
import '../../../../features/subjects/data/patriotism/lessons.dart';
import '../../../../features/subjects/data/philosophy1/subject.dart';
import '../../../../features/subjects/data/philosophy1/lessons.dart';
import '../../../../features/subjects/data/philosophy2/subject.dart';
import '../../../../features/subjects/data/philosophy2/lessons.dart';
import '../../../../features/subjects/data/physics/subject.dart';
import '../../../../features/subjects/data/physics/lessons.dart';
import '../../../../features/subjects/data/rays/subject.dart';
import '../../../../features/subjects/data/rays/lessons.dart';
import '../../../../features/subjects/data/religion/subject.dart';
import '../../../../features/subjects/data/religion/lessons.dart';
import '../../../../features/subjects/data/sciences/subject.dart';
import '../../../../features/subjects/data/sciences/lessons.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final subjectLessonsMap = {
            arabic: arabicSubjectLessons,
            analysis: analysisSubjectLessons,
            rays: raysSubjectLesson,
            physics: physicsSubjectLessons,
            chemistry: chemistrySubjectLessons,
            sciences: sciencesSubjectLessons,
            english: englishSubjectLessons,
            french: frenchSubjectLessons,
            history: historySubjectLessons,
            geography: gerographySubjectLessons,
            patriotism: patriotismSubjectLessons,
            religion: religionSubjectLessons,
            philosophy1: philosophy1SubjectLessons,
            philosophy2: philosophy2SubjectLessons,
          };
          context.pushNamed(
            Routes.pickSubject.name,
            extra: PickSubjectArguments(
              subjects: [
                arabic,
                analysis,
                rays,
                physics,
                chemistry,
                sciences,
                english,
                french,
                history,
                geography,
                patriotism,
                religion,
                philosophy1,
                philosophy2,
              ],
              getLessonCount: (subject) {
                return subjectLessonsMap[subject]?.length ?? 0;
              },
              onPickSubject: (subject) {
                final subjectLessons = subjectLessonsMap[subject] ?? [];

                final lessons =
                    subjectLessons
                        .map(
                          (sl) => Lesson(
                            id: subjectLessons.indexOf(sl) + 1,
                            title: sl.title,
                            unitId: 0,
                            questionsCount: 0,
                          ),
                        )
                        .toList();

                context.pushNamed(
                  Routes.pickSubjectLesson.name,
                  extra: PickSubjectLessonArguments(
                    subject: subject,
                    lessons: lessons,
                    onPickLesson: (lesson) {
                      // Handle lesson pick
                    },
                  ),
                );
              },
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
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
              top: SpacesResources.s4,
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
                // Expanded(
                //   child: BottomNavTab(
                //     selectedIconPath: UIImagesResources.resultsIconFilled,
                //     unselectedIconPath: UIImagesResources.resultsIconOutline,
                //     label: context.l10n.navigationResults,
                //     selected: currentIndex == 1,
                //     onTap: () => changePage(1),
                //   ),
                // ),
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
            ? Theme.of(context).colorScheme.onSurface
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
