import '../models/unit_model.dart';
import '../../domain/entities/unit.dart';

extension UnitModelExtension on UnitModel {
  Unit get toEntity {
    return Unit(
      id: id,
      title: title,
      subtitle: subtitle,
      lessonsCount: lessonsCount,
      iconUrl: iconUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UnitEntityExtension on Unit {
  UnitModel get toModel {
    return UnitModel(
      id: id,
      title: title,
      subtitle: subtitle,
      lessonsCount: lessonsCount,
      iconUrl: iconUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
