import 'package:bac_project/features/tests/data/models/test_options_model.dart';
import 'package:bac_project/features/tests/domain/entities/test_options.dart';

extension TestOptionsMapper on TestOptions {
  TestOptionsModel toModel() {
    return TestOptionsModel(
      selectedMode: selectedMode,
      selectedCategories: selectedCategories,
      selectedQuestionsCount: selectedQuestionsCount,
      selectedUnitsIDs: selectedUnitsIDs,
      selectedLessonsIDs: selectedLessonsIDs,
      categories: categories,
      enableSounds: enableSounds,
      showTrueAnswers: showTrueAnswers,
    );
  }
}

extension TestOptionsModelMapper on TestOptionsModel {
  TestOptions toEntity() {
    return TestOptions(
      selectedMode: selectedMode,
      selectedCategories: selectedCategories,
      selectedQuestionsCount: selectedQuestionsCount,
      selectedUnitsIDs: selectedUnitsIDs,
      selectedLessonsIDs: selectedLessonsIDs,
      categories: categories,
      enableSounds: enableSounds,
      showTrueAnswers: showTrueAnswers,
    );
  }
}
