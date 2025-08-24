import '../../../settings/domain/entities/governorate.dart';

class GovernorateModel extends Governorate {
  const GovernorateModel({
    required super.id,
    required super.name,
  });

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
      id: json['id'].toString(),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
