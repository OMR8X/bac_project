// Placeholder types until files feature exists in this app
import 'package:bac_project/core/services/api/responses/api_response.dart';

class BacFile {
  BacFile();
}

class BacFileModel {
  static BacFile fromJson(dynamic _) => BacFile();
}

class GetUserFavoritesResponse {
  final String? message;
  final List<BacFile> favorites;

  GetUserFavoritesResponse({required this.message, required this.favorites});

  factory GetUserFavoritesResponse.fromResponse(ApiResponse response) {
    return GetUserFavoritesResponse(
      message: response.message,
      favorites:
          (response.data as List).map((e) {
            return BacFileModel.fromJson(e);
          }).toList(),
    );
  }
}
