import '../models/unit_model.dart';
import '../../domain/entities/unit.dart';

extension UnitModelExtension on UnitModel {
  Unit toEntity() {
    return Unit(
      id: id,
      title: title,
      subtitle: subtitle,
      lessonsCount: lessonsCount,
      icon: icon,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UnitEntityExtension on Unit {
  UnitModel toModel() {
    return UnitModel(
      id: id,
      title: title,
      subtitle: subtitle,
      lessonsCount: lessonsCount,
      icon: icon,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
