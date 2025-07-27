class GetQuestionsRequest {
  final List<String> lessonsIds;

  const GetQuestionsRequest({required this.lessonsIds});

  GetQuestionsRequest copyWith({List<String>? lessonsIds}) {
    return GetQuestionsRequest(lessonsIds: lessonsIds ?? this.lessonsIds);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetQuestionsRequest && other.lessonsIds == lessonsIds;
  }

  @override
  int get hashCode => lessonsIds.hashCode;

  @override
  String toString() => 'GetQuestionsRequest(lessonsIds: $lessonsIds)';
}
