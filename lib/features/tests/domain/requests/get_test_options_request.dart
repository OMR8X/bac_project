class GetTestOptionsRequest {
  final List<String>? unitIds;
  final List<String>? lessonIds;

  const GetTestOptionsRequest({this.unitIds, this.lessonIds});

  GetTestOptionsRequest copyWith({List<String>? unitIds, List<String>? lessonIds}) {
    return GetTestOptionsRequest(
      unitIds: unitIds ?? this.unitIds,
      lessonIds: lessonIds ?? this.lessonIds,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetTestOptionsRequest &&
        other.unitIds == unitIds &&
        other.lessonIds == lessonIds;
  }

  @override
  int get hashCode => unitIds.hashCode ^ lessonIds.hashCode;

  @override
  String toString() => 'GetTestOptionsRequest(unitIds: $unitIds, lessonIds: $lessonIds)';
}
