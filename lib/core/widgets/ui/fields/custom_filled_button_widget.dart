import 'package:flutter/material.dart';

import '../../../resources/styles/border_radius_resources.dart';
import '../../../resources/styles/font_styles_manager.dart';
import '../../../resources/styles/sizes_resources.dart';
import '../../../resources/themes/extensions/color_extensions.dart';

/// A custom filled button widget with a 3D pressed effect.
///
/// Features:
/// - 3D "pressed down" effect on tap
/// - Uses [FilledButtonThemeData] from theme for colors
/// - Loading state with spinner
/// - Disabled state with reduced opacity
class CustomFilledButtonWidget extends StatefulWidget {
  const CustomFilledButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.isEnabled = true,
    this.isLoading = false,
    this.icon,
    this.height,
    this.width,
    this.backgroundColor,
    this.shadowColor,
    this.foregroundColor,
  });

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// The button text
  final String text;

  /// Whether the button is enabled
  final bool isEnabled;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Optional icon to display before the text
  final IconData? icon;

  /// Optional custom height (defaults to [SizesResources.buttonMediumHeight])
  final double? height;

  /// Optional custom width (defaults to full width)
  final double? width;

  /// Optional custom background color (overrides theme)
  final Color? backgroundColor;

  /// Optional custom shadow color (overrides theme)
  final Color? shadowColor;

  /// Optional custom foreground/text color (overrides theme)
  final Color? foregroundColor;

  @override
  State<CustomFilledButtonWidget> createState() => _CustomFilledButtonWidgetState();
}

class _CustomFilledButtonWidgetState extends State<CustomFilledButtonWidget> {
  bool _isPressed = false;

  /// The depth of the 3D effect (how much the shadow shows)
  static const double _shadowDepth = 4.0;

  /// Animation duration for the press effect
  static const Duration _animationDuration = Duration(milliseconds: 100);

  bool get _isInteractable => widget.isEnabled && !widget.isLoading && widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);
    final buttonHeight = widget.height ?? SizesResources.buttonMediumHeight;

    return Semantics(
      button: true,
      enabled: _isInteractable,
      label: widget.text,
      child: GestureDetector(
        onTapDown: _isInteractable ? (_) => _setPressed(true) : null,
        onTapUp: _isInteractable ? (_) => _handleTapUp() : null,
        onTapCancel: _isInteractable ? () => _setPressed(false) : null,
        child: AnimatedContainer(
          duration: _animationDuration,
          curve: Curves.easeOut,
          width: widget.width,
          height: buttonHeight + _shadowDepth,
          decoration: BoxDecoration(
            color: colors.shadow,
            borderRadius: BorderRadiusResource.buttonBorderRadius,
          ),
          child: Stack(
            children: [
              // Main button surface
              AnimatedPositioned(
                duration: _animationDuration,
                curve: Curves.easeOut,
                top: _isPressed ? _shadowDepth : 0,
                left: 0,
                right: 0,
                child: Container(
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadiusResource.buttonBorderRadius,
                  ),
                  child: Center(
                    child:
                        widget.isLoading
                            ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colors.foreground,
                                ),
                              ),
                            )
                            : _buildContent(colors.foreground),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Color foregroundColor) {
    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, color: foregroundColor, size: 18),
          const SizedBox(width: 8),
          Text(
            widget.text,
            style: TextStylesResources.button.copyWith(color: foregroundColor),
          ),
        ],
      );
    }

    return Text(
      widget.text,
      style: TextStylesResources.button.copyWith(color: foregroundColor),
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

  /// Get colors from theme's FilledButtonThemeData
  _ButtonColors _getColors(BuildContext context) {
    final theme = Theme.of(context);
    final filledButtonStyle = theme.filledButtonTheme.style;
    final colorScheme = theme.colorScheme;

    // Resolve background color from theme
    final themeBackground = filledButtonStyle?.backgroundColor?.resolve({}) ?? colorScheme.primary;

    // Resolve foreground color from theme
    final themeForeground =
        filledButtonStyle?.foregroundColor?.resolve({}) ?? colorScheme.onPrimary;

    // Use custom colors if provided, otherwise use theme colors
    final background = widget.backgroundColor ?? themeBackground;
    final foreground = widget.foregroundColor ?? themeForeground;
    final shadow = widget.shadowColor ?? background.darker(0.2);

    // Use disabled colors if not enabled
    if (!_isInteractable) {
      final disabledBackground =
          filledButtonStyle?.backgroundColor?.resolve({WidgetState.disabled}) ??
          colorScheme.onSurface.withAlpha(31);
      final disabledForeground =
          filledButtonStyle?.foregroundColor?.resolve({WidgetState.disabled}) ??
          colorScheme.onSurface.withAlpha(97);

      return _ButtonColors(
        background: disabledBackground,
        shadow: disabledBackground.darker(0.1),
        foreground: disabledForeground,
      );
    }

    return _ButtonColors(
      background: background,
      shadow: shadow,
      foreground: foreground,
    );
  }
}

/// Internal class to hold button colors
class _ButtonColors {
  final Color background;
  final Color shadow;
  final Color foreground;

  const _ButtonColors({
    required this.background,
    required this.shadow,
    required this.foreground,
  });
}
