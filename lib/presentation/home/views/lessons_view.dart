import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/widgets/ui/search_bar_widget.dart';
import 'package:bac_project/presentation/home/widgets/lessons_navigation_card_bilder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/widgets/ui/loading_widget.dart';
import '../blocs/lessons_bloc.dart';

class LessonsView extends StatelessWidget {
  final LessonsViewArguments? arguments;

  const LessonsView({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationManager().get(LocalizationKeys.lessons.title)),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.close_outlined),
        ),
      ),
      body: BlocProvider(
        create: (_) => LessonsBloc()..add(LessonsEventInitialize(unitId: arguments?.unitId)),
        child: BlocBuilder<LessonsBloc, LessonsState>(
          builder: (context, state) {
            if (state is LessonsLoading) {
              return const LoadingWidget();
            } else if (state is LessonsLoaded) {
              return Padding(
                padding: PaddingResources.screenSidesPadding,
                child: Column(
                  children: [
                    Padding(
                      padding: PaddingResources.searchBarPadding,
                      child: SearchBarWidget(
                        onChanged: (value) {
                          // Handle search text changes
                        },
                        onFieldSubmitted: (value) {
                          // Handle search submission
                        },
                      ),
                    ),
                    Expanded(child: LessonsCardsBuilderWidget(lessons: state.lessons)),
                  ],
                ),
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
}
