import 'package:equatable/equatable.dart';

class NotificationsTopic extends Equatable {
  final int id;
  final String title;
  final String? description;
  final String firebaseTopic;
  final bool subscribable;

  const NotificationsTopic({
    required this.id,
    required this.title,
    required this.firebaseTopic,
    this.description,
    this.subscribable = true,
  });

  factory NotificationsTopic.empty() {
    return const NotificationsTopic(id: 0, title: '', firebaseTopic: '');
  }

  NotificationsTopic copyWith({
    int? id,
    String? title,
    String? description,
    String? firebaseTopic,
    bool? subscribable,
  }) {
    return NotificationsTopic(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      firebaseTopic: firebaseTopic ?? this.firebaseTopic,
      subscribable: subscribable ?? this.subscribable,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'firebase_topic': firebaseTopic,
      'subscribable': subscribable,
    };
  }



  @override
  List<Object?> get props => [id, title, description, firebaseTopic, subscribable];
}
