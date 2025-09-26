class SubscribeToTopicRequest {
  final int topicId;
  final String topicName;

  SubscribeToTopicRequest({required this.topicId, required this.topicName});

  Map<String, dynamic> toJsonBody() {
    return {
      'p_topic_id': topicId,
    };
  }
}
