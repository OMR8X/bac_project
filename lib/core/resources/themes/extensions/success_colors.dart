import 'package:flutter/material.dart';

class SuccessColors extends ThemeExtension<SuccessColors> {
  final Color success;
  final Color onSuccess;

  SuccessColors({
    required this.success,
    required this.onSuccess,
  });

  @override
  SuccessColors copyWith({
    Color? success,
    Color? onSuccess,
  }) {
    return SuccessColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
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
    );
  }
}
