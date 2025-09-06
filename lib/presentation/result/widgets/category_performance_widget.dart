import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:flutter/material.dart';

class CategoryPerformanceWidget extends StatelessWidget {
  const CategoryPerformanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: PaddingResources.cardOuterPadding,
      child: Padding(
        padding: PaddingResources.cardMediumInnerPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Best Performance Group
            Expanded(
              child: _PerformanceGroup(
                title: 'أفضل الأداءات',
                indicators: const [
                  _PerformanceIndicator(title: 'الرياضيات', value: 0.95),
                  _PerformanceIndicator(title: 'الفيزياء', value: 0.88),
                  _PerformanceIndicator(title: 'الكيمياء', value: 0.82),
                  _PerformanceIndicator(title: 'اللغة العربية', value: 0.85),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Worst Performance Group
            Expanded(
              child: _PerformanceGroup(
                title: 'الأداءات التي تحتاج تحسين',
                indicators: const [
                  _PerformanceIndicator(title: 'التاريخ', value: 0.45),
                  _PerformanceIndicator(title: 'الجغرافيا', value: 0.52),
                  _PerformanceIndicator(title: 'العلوم الطبيعية', value: 0.38),
                  _PerformanceIndicator(title: 'اللغة الإنجليزية', value: 0.25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PerformanceGroup extends StatelessWidget {
  const _PerformanceGroup({required this.title, required this.indicators});

  final String title;
  final List<_PerformanceIndicator> indicators;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: FontSizeResources.s12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: SpacesResources.s4),
        ...indicators.map(
          (indicator) => Padding(padding: const EdgeInsets.only(bottom: 8.0), child: indicator),
        ),
      ],
    );
  }
}

class _PerformanceIndicator extends StatelessWidget {
  const _PerformanceIndicator({required this.title, required this.value});

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: FontSizeResources.s10),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: FontSizeResources.s10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 4,
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              valueColor: AlwaysStoppedAnimation<Color>(_getPerformanceColor(context, value)),
            ),
          ),
        ),
      ],
    );
  }

  Color _getPerformanceColor(BuildContext context, double value) {
    if (value >= 0.8) {
      return Theme.of(context).colorScheme.primary.lighter(0.4);
    } else if (value >= 0.6) {
      return Theme.of(context).colorScheme.primary.lighter(0.4);
    } else {
      return Theme.of(context).colorScheme.primary.lighter(0.4);
    }
  }
}
