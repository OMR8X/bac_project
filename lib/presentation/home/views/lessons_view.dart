import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/services/router/routes.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/arrow_back_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/search_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/switch_theme_icon_widget.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart';
import 'package:bac_project/presentation/home/widgets/lessons_navigation_card_bilder_widget.dart';
import 'package:bac_project/presentation/home/widgets/lessons_test_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/resources/styles/spacing_resources.dart';
import '../../../core/widgets/animations/skeletonizer_effect_list_wraper.dart';
import '../../../core/widgets/ui/lesson_card_widget.dart';
import '../blocs/lessons_bloc.dart';

class LessonsView extends StatefulWidget {
  final LessonsViewArguments? arguments;

  const LessonsView({super.key, this.arguments});

  @override
  State<LessonsView> createState() => _LessonsViewState();
}

class _LessonsViewState extends State<LessonsView> {
  @override
  void initState() {
    context.read<LessonsBloc>().add(LessonsEventInitialize(unitId: widget.arguments?.unitId));
    super.initState();
  }

  void _navigateToSearch() {
    context.pushNamed(
      Routes.search.name,
      extra: SearchViewArguments(unitId: widget.arguments?.unitId, heroTag: 'lessons_search_bar'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.lessonsTitle),
        leading: ArrowBackIconWidget(),
        actions: [SearchIconWidget(onPressed: _navigateToSearch), SwitchThemeIconWidget()],
      ),
      body: BlocProvider(
        create: (_) => context.read<LessonsBloc>(),
        child: BlocBuilder<LessonsBloc, LessonsState>(
          builder: (context, state) {
            if (state is LessonsLoading) {
              return _LoadingView();
            } else if (state is LessonsLoaded) {
              return _LoadedView(state: state, navigateToTestAllLessons: _navigateToTestAllLessons);
            } else if (state is LessonsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _navigateToTestAllLessons(BuildContext context, List<Lesson> lessons) {
    context.pushReplacementNamed(
      Routes.pickLessons.name,
      extra: PickLessonsArguments(unitId: widget.arguments?.unitId ?? 0),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({required this.state, required this.navigateToTestAllLessons});

  final LessonsLoaded state;
  final void Function(BuildContext context, List<Lesson> lessons) navigateToTestAllLessons;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: Paddings.screenSidesPadding,
          child: CustomScrollView(
            slivers: [
              SliverFloatingHeader(
                snapMode: FloatingHeaderSnapMode.overlay,
                child: StaggeredItemWrapperWidget(
                  position: 0,
                  child: LessonsTestCardWidget(
                    lessonCount: state.lessons.length,
                    onTestAllLessonsPressed: () {
                      navigateToTestAllLessons(context, state.lessons);
                    },
                  ),
                ),
              ),

              SliverPadding(
                padding: Paddings.listViewPadding,
                sliver: LessonsCardsBuilderWidget(lessons: state.lessons),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: Theme.of(context).colorScheme.surface,
      child: _LoadedView(
        state: LessonsLoaded(lessons: List.generate(10, (index) => Lesson.mock())),
        navigateToTestAllLessons: (_, _) {},
      ),
    );
  }
}
