import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/services/local/local_card_api.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/custom_action_card_widget.dart';
import 'package:bac_project/presentation/home/models/custom_action_card_model.dart' show CustomCardData;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// api المحلي

class HomeCardsBuilderWidget extends StatelessWidget {
  const HomeCardsBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredListWrapperWidget(
      position: 60,
      child: FutureBuilder<List<CustomCardData>>(
        future: LocalActionCardApi.fetchCardsFromJson('assets/json/action_card_data.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد بيانات'));
          }

          final cards = snapshot.data!;

          return ListView.builder(
            padding: PaddingResources.listViewPadding,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];

              return StaggeredItemWrapperWidget(
                position: 70,
                child: CustomActionCardWidget(
                  title: card.title,
                  subtitle: card.subtitle,
                  firstButtonText: card.firstButtonText,
                  secondButtonText: card.secondButtonText,
                  onFirstPressed: () => context.push(AppRoutes.lessons.path),
                  onSecondPressed: () => context.push(AppRoutes.lessons.path),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
