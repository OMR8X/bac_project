import 'package:neuro_app/core/extensions/build_context_l10n.dart';
import 'package:neuro_app/core/resources/styles/spacing_resources.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../features/subjects/domain/entities/subject.dart';
import '../../../core/widgets/ui/icons/switch_theme_icon_widget.dart';
import '../widgets/subject_card_widget.dart';

class PickSubjectView extends StatelessWidget {
  const PickSubjectView({
    super.key,
    required this.subjects,
    required this.onPickSubject,
    required this.getLessonCount,
  });

  final List<Subject> subjects;
  final void Function(Subject) onPickSubject;
  final int Function(Subject) getLessonCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.pickSubjectTitle),
        actions: [
          if (kDebugMode) SwitchThemeIconWidget(),
        ],
      ),
      body: Padding(
        padding: Paddings.screenBodyPadding,
        child: ListView.builder(
          padding: Paddings.listViewPadding,
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return SubjectCardWidget(
              subject: subject,
              lessonsCount: getLessonCount(subject),
              onTap: () => onPickSubject(subject),
            );
          },
        ),
      ),
    );
  }
}
