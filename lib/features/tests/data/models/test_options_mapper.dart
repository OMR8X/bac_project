import 'package:neuro_app/features/tests/data/models/test_options_model.dart';
import 'package:neuro_app/features/tests/domain/entities/test_options.dart';

extension TestOptionsMapper on TestOptions {
  TestOptionsModel get toModel {
    return TestOptionsModel(
      selectedMode: selectedMode,
      selectedCategories: selectedCategories,
      selectedQuestionsCount: selectedQuestionsCount,
      selectedUnitsIds: selectedUnitsIds,
      selectedLessonsIds: selectedLessonsIds,
      categories: categories,
      enableSounds: enableSounds,
      showTrueAnswers: showTrueAnswers,
    );
  }
}

extension TestOptionsModelMapper on TestOptionsModel {
  TestOptions get toEntity {
    return TestOptions(
      selectedMode: selectedMode,
      selectedCategories: selectedCategories,
      selectedQuestionsCount: selectedQuestionsCount,
      selectedUnitsIds: selectedUnitsIds,
      selectedLessonsIds: selectedLessonsIds,
      categories: categories,
      enableSounds: enableSounds,
      showTrueAnswers: showTrueAnswers,
    );
  }
}
