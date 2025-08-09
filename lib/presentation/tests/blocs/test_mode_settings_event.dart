part of 'test_mode_settings_bloc.dart';

sealed class TestModeSettingsEvent extends Equatable {
  const TestModeSettingsEvent();

  @override
  List<Object?> get props => [];
}

final class TestModeSettingsLoadEvent extends TestModeSettingsEvent {
  final TestOptions testOptions;

  const TestModeSettingsLoadEvent({required this.testOptions});

  @override
  List<Object?> get props => [testOptions];
}

final class TestModeSettingsUpdateModeEvent extends TestModeSettingsEvent {
  final TestMode selectedMode;

  const TestModeSettingsUpdateModeEvent({required this.selectedMode});

  @override
  List<Object> get props => [selectedMode];
}

final class TestModeSettingsSubmitEvent extends TestModeSettingsEvent {
  const TestModeSettingsSubmitEvent();

  @override
  List<Object> get props => [];
}
