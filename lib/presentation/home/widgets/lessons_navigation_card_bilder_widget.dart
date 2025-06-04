import 'package:bac_project/core/services/local/local_card_api.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/custom_navigator_card_widget.dart';
import 'package:bac_project/presentation/home/models/custom_action_card_model.dart' show CustomCardData;
import 'package:bac_project/presentation/home/models/custom_navigation_card_model.dart';
import 'package:bac_project/presentation/home/views/lessons_view.dart';
import 'package:flutter/material.dart';
// api المحلي

class LessonsCardsBuilderWidget extends StatelessWidget {
  const LessonsCardsBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredListWrapperWidget(
      position: 60,
      child: FutureBuilder<List<CustomNavigationCardData>>(
        future: LocalNavigationCardApi.fetchCardsFromJson('assets/json/navigation_card_data.json'),
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
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];

              return StaggeredItemWrapperWidget(
                position: 70,
                child: CustomNavigatorCardWidget(
                  title: card.title,
                  subtitle: card.subtitle,
                  onTap: () {
                    print('تم النقر على: ${card.title}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
