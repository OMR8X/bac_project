import 'package:bac_project/features/tests/data/models/question_category_model.dart';

import '../../domain/entities/question_category.dart';

class GetTestOptionsResponse {
  final List<QuestionCategory> categories;

  const GetTestOptionsResponse({required this.categories});

  GetTestOptionsResponse copyWith({List<QuestionCategory>? categories}) {
    return GetTestOptionsResponse(categories: categories ?? this.categories);
  }

  factory GetTestOptionsResponse.fromJson(Map<String, dynamic> json) {
    return GetTestOptionsResponse(
      categories:
          (json['categories'] as List).map((category) {
            return QuestionCategoryModel.fromJson(category as Map<String, dynamic>);
          }).toList(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetTestOptionsResponse && other.categories == categories;
  }

  @override
  int get hashCode => categories.hashCode;

  @override
  String toString() => 'GetTestOptionsResponse(categories: $categories)';
}
