import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/unit_card_widget.dart';
import 'package:bac_project/presentation/home/models/custom_action_card_model.dart'
    show CustomCardData;
import 'package:bac_project/features/tests/domain/entities/unit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCardsBuilderWidget extends StatelessWidget {
  final List<CustomCardData> cards;
  final List<Unit> units;

  const HomeCardsBuilderWidget({super.key, required this.cards, required this.units});

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return const SliverToBoxAdapter(child: Center(child: Text('لا توجد بيانات')));
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final card = cards[index];
        final unit = units[index];
        return StaggeredItemWrapperWidget(
          position: index,
          child: UnitCardWidget(
            icon: Icons.book,
            title: card.title,
            subtitle: card.subtitle,
            lessonsCount: unit.lessonsCount,
            onStartTestPressed:
                () => context.push(
                  AppRoutes.pickLessons.path,
                  extra: PickLessonsArguments(unitId: unit.id),
                ),
            onExploreLessonsPressed:
                () => context.push(
                  AppRoutes.lessons.path,
                  extra: LessonsViewArguments(unitId: unit.id),
                ),
          ),
        );
      }, childCount: cards.length),
    );
  }
}
