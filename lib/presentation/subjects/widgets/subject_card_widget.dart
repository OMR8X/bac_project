import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';
import '../../../../features/subjects/domain/entities/subject.dart';

// build-card-widget-skill: applied
class SubjectCardWidget extends StatelessWidget {
  const SubjectCardWidget({
    super.key,
    required this.subject,
    required this.lessonsCount,
    this.onTap,
  });

  final Subject subject;
  final int lessonsCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Margins.cardMargin,
      child: InkWell(
        borderRadius: BorderRadiusResource.cardBorderRadius,
        onTap: onTap,
        child: Padding(
          padding: Paddings.cardLargePadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIconBox(context),
              const SizedBox(width: SpacesResources.s6),
              Expanded(child: _buildTextInformation(context)),
              // Keeping arrow but making it subtle if strictly matching UnitCard might mean removing it,
              // but for a clickable list item an arrow is good UX.
              // User said "size and layout". UnitCard info section usually doesn't have an arrow, but I'll add it
              // as a trailing element to ensure it still feels like a navigation card, or I can remove it if "same" is strict.
              // Given UnitCard codes shows it doesn't have an arrow in the info section (it has buttons below),
              // but this IS the interaction. I will use a subtle arrow or just rely on the card click.
              // Let's stick to valid list item design. UnitCard uses Column > Row.
              // I will use Row > [Icon, Text, Arrow] to be safe for navigation.
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size:
                    FontSizeResources
                        .s12, // smaller arrow matching unit card lesson icon size roughly
                color: Colors.grey, // Placeholder, usually onSurfaceVariant
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacesResources.s6),
      decoration: BoxDecoration(
        color: subject.color.withOpacity(0.1), // Keep subject branding
        borderRadius: BorderRadiusResource.tileBoxBorderRadius,
      ),
      child: SizedBox(
        width: 28, // Match UnitCard icon size
        height: 28,
        child: Image.asset(subject.image),
      ),
    );
  }

  Widget _buildTextInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Title
        Text(
          subject.name,
          style: TextStylesResources.cardMediumTitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: FontSizeResources.s16,
            fontWeight: FontWeightResources.bold,
            height: 1.2,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: SpacesResources.s3),
        // Lessons count
        Row(
          children: [
            Icon(
              Icons.book_outlined,
              size: FontSizeResources.s12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: SpacesResources.s1),
            Text(
              "$lessonsCount درس",
              style: TextStylesResources.caption.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: FontSizeResources.s10,
                fontWeight: FontWeightResources.medium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
