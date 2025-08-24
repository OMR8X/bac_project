class GetMyResultsRequest {
  final int? lessonId;
  final int? limit;
  final int? offset;

  const GetMyResultsRequest({this.lessonId, this.limit, this.offset});

  Map<String, dynamic> toJsonBody() {
    return {
       'p_lesson_id': lessonId,
       'p_limit': limit,
       'p_offset': offset,
    };
  }
}
