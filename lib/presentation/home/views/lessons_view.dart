import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/blur_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';

import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/ui/icons/arrow_back_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/search_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/search_bar_widget.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart';
import 'package:bac_project/presentation/home/widgets/lessons_navigation_card_bilder_widget.dart';
import 'package:bac_project/presentation/home/widgets/lessons_test_card_widget.dart';
import 'package:bac_project/presentation/search/bloc/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/widgets/ui/loading_widget.dart';
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
              return const LoadingWidget();
            } else if (state is LessonsLoaded) {
              return Stack(
                children: [
                  Padding(
                    padding: PaddingResources.screenSidesPadding,
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
                          padding: PaddingResources.listViewPadding,
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
    // Extract lesson IDs from the lessons list
    final lessonIds = lessons.map((lesson) => lesson.id).toList();

    context.pushReplacementNamed(
      AppRoutes.pickLessons.name,
      extra: PickLessonsArguments(unitId: widget.arguments?.unitId ?? 0),
    );
  }
}
