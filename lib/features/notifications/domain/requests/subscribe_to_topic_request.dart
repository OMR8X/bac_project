class SubscribeToTopicRequest {
  final int topicId;
  final String firebaseTopicName;

  SubscribeToTopicRequest({required this.topicId, required this.firebaseTopicName});

  Map<String, dynamic> toJsonBody() {
    return {
      'p_topic_id': topicId,
    };
  }
}
