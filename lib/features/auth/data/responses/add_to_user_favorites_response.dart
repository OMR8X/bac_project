// Placeholder types until files feature exists in this app
import 'package:bac_project/core/services/api/responses/api_response.dart';

class BacFile {
  BacFile();
}

class BacFileModel {
  static BacFile fromJson(dynamic _) => BacFile();
}

class AddToUserFavoritesResponse {
  final String? message;
  final List<BacFile> favorites;

  AddToUserFavoritesResponse({required this.message, required this.favorites});

  factory AddToUserFavoritesResponse.fromResponse(ApiResponse response) {
    return AddToUserFavoritesResponse(
      message: response.message,
      favorites:
          (response.data as List).map((e) {
            return BacFileModel.fromJson(e);
          }).toList(),
    );
  }
}
