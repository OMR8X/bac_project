import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String uuid;
  final String name;
  final int sectionId;
  final int governorateId;
  final String email;

  const UserData({
    required this.uuid,
    required this.name,
    required this.sectionId,
    required this.governorateId,
    required this.email,
  });

  factory UserData.empty() {
    return UserData(uuid: "", name: "", sectionId: 0, governorateId: 0, email: "");
  }

  @override
  List<Object?> get props => [uuid, name, sectionId, governorateId, email];
}
