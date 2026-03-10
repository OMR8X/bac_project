import 'package:neuro_app/features/tests/data/models/option_model.dart';

import '../../domain/entities/option.dart';

extension OptionModelExtension on OptionModel {
  Option get toEntity {
    return Option(
      id: id,
      questionId: questionId,
      content: content,
      isCorrect: isCorrect,
      typedAnswer: typedAnswer,
      sortOrder: sortOrder,
    );
  }
}

extension OptionEntityExtension on Option {
  OptionModel get toModel {
    return OptionModel(
      id: id,
      questionId: questionId,
      content: content,
      isCorrect: isCorrect,
      typedAnswer: typedAnswer,
      sortOrder: sortOrder,
    );
  }
}
