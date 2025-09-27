import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/ui/icons/arrow_back_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/search_icon_widget.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart';
import 'package:bac_project/presentation/home/widgets/lessons_navigation_card_bilder_widget.dart';
import 'package:bac_project/presentation/home/widgets/lessons_test_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import '../../../core/resources/styles/spacing_resources.dart';
import '../../../core/widgets/ui/states/loading_state_body_widget.dart';
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
      AppRoutes.search.name,
      extra: SearchViewArguments(unitId: widget.arguments?.unitId, heroTag: 'lessons_search_bar'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.lessonsTitle),
        leading: ArrowBackIconWidget(),
        actions: [SearchIconWidget(onPressed: _navigateToSearch)],
      ),
      body: BlocProvider(
        create: (_) => context.read<LessonsBloc>(),
        child: BlocBuilder<LessonsBloc, LessonsState>(
          builder: (context, state) {
            if (state is LessonsLoading) {
              return const LoadingStateBodyWidget();
            } else if (state is LessonsLoaded) {
              return Stack(
                children: [
                  Padding(
                    padding: Paddings.screenSidesPadding,
                    child: CustomScrollView(
                      slivers: [
                        // Show test card only when at the top using a SliverLayoutBuilder
                        // inline search bar
                        SliverFloatingHeader(
                          snapMode: FloatingHeaderSnapMode.overlay,
                          child: LessonsTestCardWidget(
                            lessonCount: state.lessons.length,
                            onTestAllLessonsPressed: () {
                              _navigateToTestAllLessons(context, state.lessons);
                            },
                          ),
                        ),
                        // SliverToBoxAdapter(
                        //   child: ,
                        // ),
                        SliverPadding(
                          padding: Paddings.listViewPadding,
                          sliver: LessonsCardsBuilderWidget(lessons: state.lessons),
                        ),
                      ],
                    ),
                  ),
                ],
              );
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
      AppRoutes.pickLessons.name,
      extra: PickLessonsArguments(unitId: widget.arguments?.unitId ?? 0),
    );
  }
}
