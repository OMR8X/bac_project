import 'package:flutter/material.dart';

import '../../../resources/styles/border_radius_resources.dart';
import '../../../resources/themes/extensions/color_extensions.dart';

/// A wrapper widget that adds a 3D pressed effect to any button.
///
/// Wraps a button (typically [FilledButton]) and adds:
/// - A shadow underneath creating a 3D raised effect
/// - Press-down animation when tapped
///
/// Usage:
/// ```dart
/// Pressed3DButtonWrapper(
///   onPressed: () => print('Pressed!'),
///   shadowColor: Theme.of(context).colorScheme.primary.darker(0.2),
///   child: FilledButton(
///     onPressed: null, // Let wrapper handle the tap
///     child: Text('Click me'),
///   ),
/// )
/// ```
class Pressed3DButtonWrapper extends StatefulWidget {
  const Pressed3DButtonWrapper({
    super.key,
    required this.child,
    required this.onPressed,
    this.shadowColor,
    this.shadowDepth = 4.0,
    this.animationDuration = const Duration(milliseconds: 100),
    this.isEnabled = true,
  });

  /// The button widget to wrap (e.g., FilledButton, ElevatedButton)
  /// Set the button's onPressed to null to let the wrapper handle taps.
  final Widget child;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// The shadow color. If null, derives from the button's theme background color.
  final Color? shadowColor;

  /// The depth of the 3D shadow effect (default: 4.0)
  final double shadowDepth;

  /// Animation duration for the press effect (default: 100ms)
  final Duration animationDuration;

  /// Whether the button is enabled
  final bool isEnabled;

  @override
  State<Pressed3DButtonWrapper> createState() => _Pressed3DButtonWrapperState();
}

class _Pressed3DButtonWrapperState extends State<Pressed3DButtonWrapper> {
  bool _isPressed = false;

  bool get _isInteractable => widget.isEnabled && widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final shadowColor = widget.shadowColor ?? _resolveShadowColor(context);

    return GestureDetector(
      onTapDown: _isInteractable ? (_) => _setPressed(true) : null,
      onTapUp: _isInteractable ? (_) => _handleTapUp() : null,
      onTapCancel: _isInteractable ? () => _setPressed(false) : null,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: shadowColor,
          borderRadius: BorderRadiusResource.buttonBorderRadius,
        ),
        padding: EdgeInsets.only(bottom: widget.shadowDepth),
        child: AnimatedContainer(
          duration: widget.animationDuration,
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(
            0,
            _isPressed ? widget.shadowDepth : 0,
            0,
          ),
          child: widget.child,
        ),
      ),
    );
  }

  void _setPressed(bool pressed) {
    if (_isPressed != pressed) {
      setState(() => _isPressed = pressed);
    }
  }

  void _handleTapUp() {
    _setPressed(false);
    widget.onPressed?.call();
  }

  /// Resolve shadow color from the child button's theme
  Color _resolveShadowColor(BuildContext context) {
    final theme = Theme.of(context);
    final childType = widget.child.runtimeType;

    Color? backgroundColor;

    // Try to get background color from appropriate button theme
    if (childType == FilledButton) {
      backgroundColor = theme.filledButtonTheme.style?.backgroundColor?.resolve({});
    } else if (childType == ElevatedButton) {
      backgroundColor = theme.elevatedButtonTheme.style?.backgroundColor?.resolve({});
    } else if (childType == OutlinedButton) {
      backgroundColor = theme.outlinedButtonTheme.style?.backgroundColor?.resolve({});
    } else if (childType == TextButton) {
      backgroundColor = theme.textButtonTheme.style?.backgroundColor?.resolve({});
    }

    // Fallback to primary color
    backgroundColor ??= theme.colorScheme.primary;

    // Darken for shadow effect
    return backgroundColor.darker(0.2);
  }
}
