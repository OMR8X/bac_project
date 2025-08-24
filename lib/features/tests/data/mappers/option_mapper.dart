import 'package:bac_project/features/tests/data/models/option_model.dart';

import '../../domain/entities/option.dart';

extension OptionModelExtension on OptionModel {
  Option toEntity() {
    return Option(id: id, questionId: questionId, text: text, isCorrect: isCorrect);
  }
}

extension OptionEntityExtension on Option {
  OptionModel toModel() {
    return OptionModel(id: id, questionId: questionId, text: text, isCorrect: isCorrect);
  }
}
