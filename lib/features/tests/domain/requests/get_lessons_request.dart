import 'package:dio/dio.dart';

class GetLessonsRequest {
  final int? unitId;
  final String? search;
  final CancelToken? cancelToken;

  const GetLessonsRequest({this.unitId, this.search, this.cancelToken});

  Map<String, dynamic> toJsonBody() {
    return {"p_unit_id": unitId, if (search != null) "p_search": search};
  }

  GetLessonsRequest copyWith({int? unitId, String? search, CancelToken? cancelToken}) {
    return GetLessonsRequest(
      unitId: unitId ?? this.unitId,
      search: search ?? this.search,
      cancelToken: cancelToken ?? this.cancelToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetLessonsRequest &&
        other.unitId == unitId &&
        other.search == search &&
        other.cancelToken == cancelToken;
  }

  @override
  int get hashCode => unitId.hashCode ^ search.hashCode ^ cancelToken.hashCode;

  @override
  String toString() =>
      'GetLessonsRequest(unitId: $unitId, search: $search, cancelToken: $cancelToken)';
}
