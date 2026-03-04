class UpdatePasswordRequest {
  final String currentPassword;
  final String newPassword;

  UpdatePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toBody() {
    return {
      "current_password": currentPassword,
      "new_password": newPassword,
    };
  }
}
