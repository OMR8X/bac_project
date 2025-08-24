
class UserData {
  final String uuid;
  final String name;
  final String sectionId;
  final String governorateId;
  final String email;

  UserData({
    required this.uuid,
    required this.name,
    required this.sectionId,
    required this.governorateId,
    required this.email,
  });

  factory UserData.empty() {
    return UserData(
      uuid: "",
      name: "",
      sectionId: "",
      governorateId: "",
      email: "",
    );
  }


}
