import 'package:neuro_app/core/resources/styles/border_radius_resources.dart';
import 'package:neuro_app/core/resources/styles/font_styles_manager.dart';
import 'package:neuro_app/core/resources/styles/spaces_resources.dart';
import 'package:neuro_app/core/resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';
import 'planner_mock_data.dart';

/// The combined home view:
/// - Dashboard header from Variation B (streak + overall progress card)
/// - Section header with count badge from Variation B
/// - Lesson card tile design from Variation A (color bar + checkbox)
class HomeVariationA extends StatefulWidget {
  const HomeVariationA({super.key});

  @override
  State<HomeVariationA> createState() => _HomeVariationAState();
}

class _HomeVariationAState extends State<HomeVariationA> {
  late final List<MockPlannerLesson> lessons;

  @override
  void initState() {
    super.initState();
    lessons = PlannerMockData.createTodayLessons();
  }

  void _toggleLesson(int index) {
    setState(() {
      lessons[index].isCompleted = !lessons[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    final completed = PlannerMockData.completedCount(lessons);
    final total = lessons.length;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('خطة اليوم'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: Paddings.screenSidesPadding,
        child: CustomScrollView(
          slivers: [
            // ── Weekly Streak ──
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: SpacesResources.s4),
                child: _WeeklyStreakDateRow(cs: cs),
              ),
            ),

            // ── Section header ──
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  top: SpacesResources.s8,
                  bottom: SpacesResources.s4,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'دروس اليوم',
                      style: TextStylesResources.cardLargeTitle.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeightResources.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SpacesResources.s4,
                        vertical: SpacesResources.s2,
                      ),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest.withValues(alpha: 0.6),
                        borderRadius: BorderRadiusResource.bordersRadiusXLarge,
                      ),
                      child: Text(
                        '$completed / $total',
                        style: TextStylesResources.cardSmallTitle.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Empty state ──
            if (lessons.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(SpacesResources.s20),
                  child: Center(
                    child: Column(
                      children: [
                        Text('📖', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: SpacesResources.s4),
                        Text(
                          'كل رحلة تبدأ بخطوة',
                          style: TextStylesResources.headline1.copyWith(color: cs.onSurface),
                        ),
                        const SizedBox(height: SpacesResources.s2),
                        Text(
                          'اضغط + لإضافة أول درس لليوم',
                          style: TextStylesResources.title.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // ── Lesson list (card design from Variation A) ──
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final lesson = lessons[index];
                  return _LessonCard(
                    lesson: lesson,
                    onToggle: () => _toggleLesson(index),
                  );
                },
                childCount: lessons.length,
              ),
            ),

            // ── Celebration when all done ──
            if (completed == total && total > 0)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(SpacesResources.s10),
                  child: Center(
                    child: Column(
                      children: [
                        const Text('🎉', style: TextStyle(fontSize: 52)),
                        const SizedBox(height: SpacesResources.s4),
                        Text(
                          'أنهيت كل شي لليوم!',
                          style: TextStylesResources.headline1.copyWith(color: cs.onSurface),
                        ),
                        const SizedBox(height: SpacesResources.s2),
                        Text(
                          'روح كافئ حالك 🍫',
                          style: TextStylesResources.title.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Bottom spacing
            SliverToBoxAdapter(child: SizedBox(height: SpacesResources.s80)),
          ],
        ),
      ),
    );
  }
}

/// Lesson card tile: color bar on the side, title + subject, checkbox on the right.
/// Card design from Variation A.
class _LessonCard extends StatelessWidget {
  const _LessonCard({required this.lesson, required this.onToggle});

  final MockPlannerLesson lesson;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: lesson.isCompleted ? 0.55 : 1.0,
      child: Card(
        margin: Margins.cardMargin,
        // Lighter card surface — one step lighter than the default card color
        color: cs.surfaceContainerLowest,
        child: InkWell(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          onTap: onToggle,
          child: Padding(
            padding: Paddings.cardLessonPadding,
            child: Row(
              children: [
                // Subject color bar
                Container(
                  width: 4,
                  height: SpacesResources.s16,
                  decoration: BoxDecoration(
                    color: lesson.subjectColor,
                    borderRadius: BorderRadiusResource.bordersRadiusTiny,
                  ),
                ),
                const SizedBox(width: SpacesResources.s4),
                // Lesson title + subject name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lesson.title,
                        style: TextStylesResources.cardMediumTitle.copyWith(
                          color: cs.onSurface,
                          decoration: lesson.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      const SizedBox(height: SpacesResources.s1),
                      Text(
                        lesson.subject,
                        style: TextStylesResources.caption.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Checkbox — themed for natural border colours
                CheckboxTheme(
                  data: CheckboxThemeData(
                    side: BorderSide(
                      color: lesson.isCompleted ? cs.primary : cs.outline,
                      width: 1.5,
                    ),
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) return cs.primary;
                      return Colors.transparent;
                    }),
                    checkColor: WidgetStatePropertyAll(cs.onPrimary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusResource.bordersRadiusTiny,
                    ),
                  ),
                  child: SizedBox(
                    width: SpacesResources.s10,
                    height: SpacesResources.s10,
                    child: Checkbox(
                      value: lesson.isCompleted,
                      onChanged: (_) => onToggle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Weekly Streak Mock Data
// ─────────────────────────────────────────────────────────

class _WeekDay {
  final String label; // abbreviated day name (Arabic)
  final int date;
  final bool isCompleted;
  final bool isToday;

  const _WeekDay({
    required this.label,
    required this.date,
    this.isCompleted = false,
    this.isToday = false,
  });
}

List<_WeekDay> _getMockWeekDays() {
  return const [
    _WeekDay(label: 'السبت', date: 1, isCompleted: true),
    _WeekDay(label: 'الأحد', date: 2, isCompleted: true),
    _WeekDay(label: 'الاثنين', date: 3, isCompleted: true),
    _WeekDay(label: 'الثلاثاء', date: 4, isCompleted: false, isToday: true),
    _WeekDay(label: 'الأربعاء', date: 5),
    _WeekDay(label: 'الخميس', date: 6),
    _WeekDay(label: 'الجمعة', date: 7),
  ];
}

// ─────────────────────────────────────────────────────────
// Weekly Streak — Scrollable Date Row with fade edges
// ─────────────────────────────────────────────────────────

class _WeeklyStreakDateRow extends StatelessWidget {
  const _WeeklyStreakDateRow({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final days = _getMockWeekDays();
    final cardColor = Theme.of(context).cardTheme.color ?? cs.surfaceContainerLow;

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SpacesResources.s6,
          horizontal: SpacesResources.s2,
        ),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                cardColor,
                Colors.transparent,
                Colors.transparent,
                cardColor,
              ],
              stops: const [0.0, 0.07, 0.93, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstOut,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: SpacesResources.s5),
            child: Row(
              children:
                  days.map((day) {
                    final isHighlighted = day.isToday;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: SpacesResources.s1),
                      child: Container(
                        width: 50,
                        padding: const EdgeInsets.symmetric(
                          vertical: SpacesResources.s4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isHighlighted
                                  ? cs.primary
                                  : day.isCompleted
                                  ? cs.primary.withValues(alpha: 0.08)
                                  : Colors.transparent,
                          borderRadius: BorderRadiusResource.bordersRadiusSmall,
                          border:
                              (!isHighlighted && !day.isCompleted)
                                  ? Border.all(
                                    color: cs.outlineVariant,
                                    width: 2,
                                  )
                                  : null,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              day.label,
                              style: TextStylesResources.miniCaption.copyWith(
                                color: isHighlighted ? cs.onPrimary : cs.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: SpacesResources.s1),
                            Text(
                              '${day.date}',
                              style: TextStylesResources.cardMediumTitle.copyWith(
                                color:
                                    isHighlighted
                                        ? cs.onPrimary
                                        : day.isCompleted
                                        ? cs.onSurface
                                        : cs.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: SpacesResources.s1),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color:
                                    isHighlighted
                                        ? cs.onPrimary.withValues(alpha: 0.7)
                                        : day.isCompleted
                                        ? Colors.green.withValues(alpha: 0.8)
                                        : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
