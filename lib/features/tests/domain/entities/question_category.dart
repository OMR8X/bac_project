import 'package:skeletonizer/skeletonizer.dart';
import 'package:equatable/equatable.dart';

class QuestionCategory extends Equatable {
  final int id;
  final String title;
  final bool isTypeable;
  final bool isOrderable;
  final bool isMCQ;
  final bool isSingleAnswer;
  final int? questionsCount;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const QuestionCategory({
    required this.id,
    required this.title,
    this.questionsCount,
    required this.isTypeable,
    required this.isOrderable,
    required this.isMCQ,
    required this.isSingleAnswer,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory QuestionCategory.mock() {
    return QuestionCategory(
      id: 1,
      title: BoneMock.title,
      isTypeable: true,
      isOrderable: true,
      isMCQ: true,
      isSingleAnswer: true,
      questionsCount: 10,
      sortOrder: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    isTypeable,
    isOrderable,
    isMCQ,
    isSingleAnswer,
    questionsCount,
    sortOrder,
    createdAt,
    updatedAt,
  ];
}
