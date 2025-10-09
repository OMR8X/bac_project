class GetNotificationsRequest {
  final int? limit;
  final int? offset;

  GetNotificationsRequest({this.limit, this.offset});

  Map<String, dynamic> toJsonBody() {
    return {
      if (limit != null) 'limit_param': limit,
      if (offset != null) 'offset_param': offset,
    };
  }
}
