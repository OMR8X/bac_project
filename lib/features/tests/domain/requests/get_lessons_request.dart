class GetLessonsRequest {
  final String? unitId;

  const GetLessonsRequest({this.unitId});

  GetLessonsRequest copyWith({String? unitId}) {
    return GetLessonsRequest(unitId: unitId ?? this.unitId);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetLessonsRequest && other.unitId == unitId;
  }

  @override
  int get hashCode => unitId.hashCode;

  @override
  String toString() => 'GetLessonsRequest(unitId: $unitId)';
}
