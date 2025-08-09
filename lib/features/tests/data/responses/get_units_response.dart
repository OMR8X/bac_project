import 'package:bac_project/features/tests/data/models/unit_model.dart';

import '../../domain/entities/unit.dart';

class GetUnitsResponse {
  final List<Unit> units;

  const GetUnitsResponse({required this.units});

  GetUnitsResponse copyWith({List<Unit>? units}) {
    return GetUnitsResponse(units: units ?? this.units);
  }

  factory GetUnitsResponse.fromJson(Map<String, dynamic> json) {
    return GetUnitsResponse(
      units:
          (json['units'] as List)
              .map((unit) => UnitModel.fromJson(unit as Map<String, dynamic>))
              .toList(),
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetUnitsResponse && other.units == units;
  }

  @override
  int get hashCode => units.hashCode;

  @override
  String toString() => 'GetUnitsResponse(units: $units)';
}
