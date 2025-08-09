import 'package:bac_project/features/tests/domain/entities/test_mode.dart';

class TestOptions {
  final List<int>? selectedUnitsIDs;
  final List<int>? selectedTestsIDs;
  final TestMode selectedMode;

  const TestOptions({this.selectedUnitsIDs, this.selectedTestsIDs, required this.selectedMode});

  TestOptions copyWith({
    List<int>? selectedUnitsIDs,
    List<int>? selectedTestsIDs,
    TestMode? selectedMode,
  }) {
    return TestOptions(
      selectedUnitsIDs: selectedUnitsIDs ?? this.selectedUnitsIDs,
      selectedTestsIDs: selectedTestsIDs ?? this.selectedTestsIDs,
      selectedMode: selectedMode ?? this.selectedMode,
    );
  }
}
