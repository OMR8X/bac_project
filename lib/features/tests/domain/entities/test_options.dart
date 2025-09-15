import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:equatable/equatable.dart';

class TestOptions extends Equatable {
  //
  final bool showTrueAnswers, enableSounds;
  final int? selectedQuestionsCount;
  final List<int>? selectedUnitsIDs;
  final List<int>? selectedLessonsIDs;
  final List<QuestionCategory>? selectedCategories;
  //
  final List<QuestionCategory>? categories;
  final TestMode selectedMode;

  const TestOptions({
    required this.showTrueAnswers,
    required this.enableSounds,
    this.selectedQuestionsCount,
    this.selectedUnitsIDs,
    this.selectedLessonsIDs,
    required this.selectedCategories,
    this.categories,
    required this.selectedMode,
  });

  TestOptions copyWith({
    bool? showTrueAnswers,
    bool? enableSounds,
    int? selectedQuestionsCount,
    List<int>? selectedUnitsIDs,
    List<int>? selectedLessonsIDs,
    List<QuestionCategory>? selectedCategories,
    List<QuestionCategory>? categories,
    TestMode? selectedMode,
    bool setSelectedQuestionsCountNull = false,
  }) {
    return TestOptions(
      showTrueAnswers: showTrueAnswers ?? this.showTrueAnswers,
      enableSounds: enableSounds ?? this.enableSounds,
      selectedQuestionsCount:
          setSelectedQuestionsCountNull
              ? null
              : selectedQuestionsCount ?? this.selectedQuestionsCount,
      selectedUnitsIDs: selectedUnitsIDs ?? this.selectedUnitsIDs,
      selectedLessonsIDs: selectedLessonsIDs ?? this.selectedLessonsIDs,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      categories: categories ?? this.categories,
      selectedMode: selectedMode ?? this.selectedMode,
    );
  }

  List<int> countOptions({int padding = 20}) {
    List<int> options = [];

    // Calculate maximum available questions from selected categories
    int? calculatedMax = selectedCategories?.fold(0, (total, category) {
      return (total ?? 0) + (category.questionsCount ?? 0);
    });

    // Return empty list if no categories selected or max is 0
    if (calculatedMax == null || calculatedMax == 0) return [];

    // Cap the maximum at 100
    int max = calculatedMax > 100 ? 100 : calculatedMax;

    // Ensure we have at least 10 questions minimum
    if (max < 10) return [max];

    // If max is less than padding, use smaller increments or just return max
    if (max < padding) {
      // For small numbers, use increments of 10 or just return the max
      if (max >= 10) {
        int current = 10;
        while (current <= max) {
          options.add(current);
          current += 10;
        }
        // Add max if it's not already included
        if (options.last != max) {
          options.add(max);
        }
      } else {
        // For very small numbers, just return the max
        options.add(max);
      }
      return options;
    }

    // Generate clean multiples starting from padding value
    int current = padding;

    // Add options as clean multiples of padding
    while (current <= max) {
      options.add(current);
      current += padding;
    }

    // If max is not a clean multiple of padding, add it as the final option
    if (options.isNotEmpty && options.last != max && max % padding != 0) {
      options.add(max);
    }

    return options;
  }

  @override
  List<Object?> get props => [
    showTrueAnswers,
    enableSounds,
    selectedQuestionsCount,
    selectedUnitsIDs,
    selectedLessonsIDs,
    selectedCategories,
    categories,
    selectedMode,
  ];
}
