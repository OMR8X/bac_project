import 'package:bac_project/features/tests/domain/entities/test_options.dart';

class GetQuestionsRequest {
  final TestOptions options;

  const GetQuestionsRequest({required this.options});

  GetQuestionsRequest copyWith({TestOptions? options}) {
    return GetQuestionsRequest(options: options ?? this.options);
  }

  Map<String, dynamic> toJsonBody() {
    return {
      // 'p_test_mode': options.selectedMode.name,
      'p_selected_categories': options.selectedCategories?.map((e) => e.id).toList(),
      'p_questions_count': options.selectedQuestionsCount,
      'p_lessons_ids': options.selectedLessonsIDs,
      'p_show_true_answers': options.showTrueAnswers,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetQuestionsRequest && other.options == options;
  }

  @override
  int get hashCode => options.hashCode;

  @override
  String toString() => 'GetQuestionsRequest(options: $options)';
}
