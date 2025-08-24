import '../../domain/entities/user_answer.dart';

class UserAnswerModel extends UserAnswer {
  const UserAnswerModel({required super.questionId, super.selectedOptionId});

  factory UserAnswerModel.fromJson(Map<String, dynamic> json) {
    return UserAnswerModel(
      questionId: json['question_id'] as int,
      selectedOptionId: json['selected_option_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'question_id': questionId, 'selected_option_id': selectedOptionId};
  }

  @override
  UserAnswerModel copyWith({int? questionId, int? selectedOptionId}) {
    return UserAnswerModel(
      questionId: questionId ?? this.questionId,
      selectedOptionId: selectedOptionId ?? this.selectedOptionId,
    );
  }
}
