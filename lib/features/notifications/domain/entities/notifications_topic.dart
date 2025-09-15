import 'package:equatable/equatable.dart';

class NotificationsTopic extends Equatable {
  final String id;
  final String title;

  const NotificationsTopic({required this.id, required this.title});

  factory NotificationsTopic.initial() {
    return const NotificationsTopic(id: "", title: "");
  }

  NotificationsTopic copyWith({String? id, String? title}) {
    return NotificationsTopic(id: id ?? this.id, title: title ?? this.title);
  }

  @override
  List<Object?> get props => [id, title];
}
