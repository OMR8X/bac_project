import 'package:flutter/material.dart';

class SuccessColors extends ThemeExtension<SuccessColors> {
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  SuccessColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
  });

  @override
  SuccessColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
  }) {
    return SuccessColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
    );
  }

  @override
  SuccessColors lerp(ThemeExtension<SuccessColors>? other, double t) {
    if (other is! SuccessColors) {
      return this;
    }
    return SuccessColors(
      success: Color.lerp(success, other.success, t) ?? success,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      successContainer: Color.lerp(successContainer, other.successContainer, t) ?? successContainer,
    );
  }
}

