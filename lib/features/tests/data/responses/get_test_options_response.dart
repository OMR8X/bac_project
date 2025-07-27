import '../models/test_options_model.dart';
import '../../domain/entities/test_options.dart';

class GetTestOptionsResponse {
  final TestOptions testOptions;

  const GetTestOptionsResponse({required this.testOptions});

  GetTestOptionsResponse copyWith({TestOptions? testOptions}) {
    return GetTestOptionsResponse(testOptions: testOptions ?? this.testOptions);
  }

  factory GetTestOptionsResponse.fromJson(Map<String, dynamic> json) {
    return GetTestOptionsResponse(
      testOptions: TestOptionsModel.fromJson(json['test_options'] as Map<String, dynamic>),
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetTestOptionsResponse && other.testOptions == testOptions;
  }

  @override
  int get hashCode => testOptions.hashCode;

  @override
  String toString() => 'GetTestOptionsResponse(testOptions: $testOptions)';
}
