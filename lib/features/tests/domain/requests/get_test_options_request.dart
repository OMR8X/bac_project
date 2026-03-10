class GetTestOptionsRequest {
  // final List<String>? unitIds;
  final List<String>? lessonIds;

  const GetTestOptionsRequest({this.lessonIds});

  Map<String, dynamic> toJsonBody() {
    return {'p_lessons_ids': lessonIds};
  }

  GetTestOptionsRequest copyWith({List<String>? lessonIds}) {
    return GetTestOptionsRequest(
      lessonIds: lessonIds ?? this.lessonIds,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetTestOptionsRequest && other.lessonIds == lessonIds;
  }

  @override
  int get hashCode => lessonIds.hashCode;

  @override
  String toString() => 'GetTestOptionsRequest(lessonIds: $lessonIds)';
}
