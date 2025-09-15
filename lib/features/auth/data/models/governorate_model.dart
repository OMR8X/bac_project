import '../../../settings/domain/entities/governorate.dart';

class GovernorateModel extends Governorate {
  const GovernorateModel({required super.id, required super.title});

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
