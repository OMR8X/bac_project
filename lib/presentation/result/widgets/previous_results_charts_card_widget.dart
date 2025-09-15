import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PreviousResultsChartsCardWidget extends StatelessWidget {
  const PreviousResultsChartsCardWidget({super.key, required this.results});

  final List<Result> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SfCartesianChart(
          plotAreaBorderWidth: 0, // ✅ remove chart outline
          // margin: const EdgeInsets.all(4), // ✅ tighter chart margins
          legend: Legend(
            isVisible: true,
            position: LegendPosition.top,
            alignment: ChartAlignment.far,
            overflowMode: LegendItemOverflowMode.wrap,
            textStyle: const TextStyle(fontSize: 10), // ✅ smaller legend text
          ),
          primaryXAxis: CategoryAxis(
            labelStyle: const TextStyle(fontSize: 9),
            majorGridLines: const MajorGridLines(width: 0), // ✅ no vertical grid
            majorTickLines: const MajorTickLines(size: 0), // ✅ no tick marks
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 100,
            interval: 25,
            labelFormat: '{value}',
            labelStyle: const TextStyle(fontSize: 9),
            axisLine: const AxisLine(width: 0), // ✅ hide Y axis line
            majorGridLines: MajorGridLines(
              width: 1,
              color: Theme.of(context).colorScheme.outline,
              dashArray: [4, 4],
            ), // ✅ light dashed grid
            majorTickLines: const MajorTickLines(size: 0), // ✅ no tick marks
          ),

          series: <CartesianSeries<dynamic, dynamic>>[
            // Correct (black)
            StackedColumn100Series<Result, String>(
              dataSource: results,
              xValueMapper: (Result data, _) => data.createdAt.day.toString(),
              yValueMapper: (Result data, _) => data.correctAnswers,
              name: 'صحيح',
              color: Theme.of(context).colorScheme.onSurface.lighter(0.25),
              width: 0.5,
              spacing: 0.2,
            ),
            // Wrong (red)
            StackedColumn100Series<Result, String>(
              dataSource: results,
              xValueMapper: (Result data, _) => data.createdAt.day.toString(),
              yValueMapper: (Result data, _) => data.wrongAnswers,
              name: 'Wrong',
              color: Theme.of(context).extension<ExtraColors>()!.red.lighter(0.25),
              width: 0.5,
              spacing: 0.2,
            ),
            // Skipped (grey)
            StackedColumn100Series<Result, String>(
              dataSource: results,
              xValueMapper: (Result data, _) => data.createdAt.day.toString(),
              yValueMapper: (Result data, _) => 0,
              name: 'Skipped',
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 0.5,
              spacing: 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
