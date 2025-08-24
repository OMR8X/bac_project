class UserAnswer {
  final int questionId;
  final int? selectedOptionId;

  const UserAnswer({required this.questionId, this.selectedOptionId});

  UserAnswer copyWith({int? questionId, int? selectedOptionId}) {
    return UserAnswer(
      questionId: questionId ?? this.questionId,
      selectedOptionId: selectedOptionId ?? this.selectedOptionId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserAnswer &&
        other.questionId == questionId &&
        other.selectedOptionId == selectedOptionId;
  }

  @override
  int get hashCode => questionId.hashCode ^ (selectedOptionId?.hashCode ?? 0);

  @override
  String toString() => 'UserAnswer(questionId: $questionId, selectedOptionId: $selectedOptionId)';
}
