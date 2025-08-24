class AddToUserFavoritesRequest {
  final String fileId;

  AddToUserFavoritesRequest({
    required this.fileId,
  });

  Map<String, dynamic> toBody() {
    return {
      "file_id": fileId,
    };
  }
}
