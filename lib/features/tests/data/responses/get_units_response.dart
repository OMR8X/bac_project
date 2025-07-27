import 'package:bac_project/features/tests/data/models/unit_model.dart';

import '../../domain/entities/unit.dart';

class GetUnitsResponse {
  final List<Unit> units;
  final int totalCount;

  const GetUnitsResponse({required this.units, required this.totalCount});

  GetUnitsResponse copyWith({List<Unit>? units, int? totalCount}) {
    return GetUnitsResponse(
      units: units ?? this.units,
      totalCount: totalCount ?? this.totalCount,
    );
  }
  factory GetUnitsResponse.fromJson(Map<String, dynamic> json) {
    return GetUnitsResponse(
      units:
          (json['units'] as List)
              .map((unit) => UnitModel.fromJson(unit as Map<String, dynamic>))
              .toList(),
      totalCount: json['totalCount'] as int,
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetUnitsResponse &&
        other.units == units &&
        other.totalCount == totalCount;
  }

  @override
  int get hashCode => units.hashCode ^ totalCount.hashCode;

  @override
  String toString() =>
      'GetUnitsResponse(units: $units, totalCount: $totalCount)';
}
