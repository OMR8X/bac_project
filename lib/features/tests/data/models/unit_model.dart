import '../../domain/entities/unit.dart';

class UnitModel extends Unit {
  const UnitModel({required super.id, required super.title, required super.subtitle});

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'subtitle': subtitle};
  }



  @override
  UnitModel copyWith({String? id, String? title, String? subtitle}) {
    return UnitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UnitModel &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ subtitle.hashCode;

  @override
  String toString() => 'UnitModel(id: $id, title: $title, subtitle: $subtitle)';
}
