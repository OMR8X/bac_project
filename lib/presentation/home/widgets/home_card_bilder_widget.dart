import 'package:bac_project/core/services/local/local_card_api.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/custom_action_card_widget.dart';
import 'package:bac_project/presentation/home/models/custom_card_model.dart'
    show CustomCardData;
import 'package:flutter/material.dart';
// api المحلي

class HomeCardsBuilderWidget extends StatelessWidget {
  const HomeCardsBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredListWrapperWidget(
      position: 60,
      child: FutureBuilder<List<CustomCardData>>(
        future: LocalCardApi.fetchCardsFromJson(),
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
                child: CustomActionCardWidget(
                  title: card.title,
                  subtitle: card.subtitle,
                  firstButtonText: card.firstButtonText,
                  secondButtonText: card.secondButtonText,
                  onFirstPressed: () => print('${card.title} - اختبار'),
                  onSecondPressed: () => print('${card.title} - دروس'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
