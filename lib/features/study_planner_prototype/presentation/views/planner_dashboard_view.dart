import 'package:flutter/material.dart';
import '../../domain/entities/mock_study_data.dart';
import '../widgets/planner_analytics_card.dart';
import '../widgets/planner_todo_item.dart';
import '../../../../core/resources/styles/colors_resources.dart';
import '../../../../core/widgets/ui/icons/switch_theme_icon_widget.dart';
import 'planner_add_lesson_view.dart';

class PlannerDashboardView extends StatefulWidget {
  const PlannerDashboardView({super.key});

  @override
  State<PlannerDashboardView> createState() => _PlannerDashboardViewState();
}

class _PlannerDashboardViewState extends State<PlannerDashboardView> {
  // Local state refresh
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Study Planner Prototype'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        actions: const [
          SwitchThemeIconWidget(),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: PlannerAnalyticsCard(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Today\'s Lessons',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (MockStudyData.currentTodos.isEmpty)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'No lessons added yet.\nTap + to add one!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final lesson = MockStudyData.currentTodos[index];
                    return PlannerTodoItem(
                      lesson: lesson,
                      onToggle: () {
                        setState(() {
                          lesson.isCompleted = !lesson.isCompleted;
                        });
                      },
                    );
                  },
                  childCount: MockStudyData.currentTodos.length,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PlannerAddLessonView(),
            ),
          );
          _refresh(); // Refresh state after returning
        },
        backgroundColor: ColorsResourcesLight.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
