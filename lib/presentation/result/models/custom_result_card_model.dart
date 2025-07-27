import 'package:equatable/equatable.dart';

class CustomResultCardData extends Equatable {
  final String title;
  final String score;
  final String date;

  const CustomResultCardData({
    required this.title,
    required this.score,
    required this.date,
  });

  factory CustomResultCardData.fromJson(Map<String, dynamic> json) {
    return CustomResultCardData(
      title: json['title'] as String,
      score: json['score'] as String,
      date: json['date'] as String,
    );
  }

  @override
  List<Object> get props => [title, score, date];
}
