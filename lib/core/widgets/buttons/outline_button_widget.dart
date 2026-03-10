import 'package:neuro_app/core/resources/styles/border_radius_resources.dart';
import 'package:flutter/material.dart';

class OutlineButtonWidget extends StatefulWidget {
  const OutlineButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.elevation = 4.0,
  });

  final void Function()? onPressed;
  final Widget child;
  final double elevation;

  @override
  State<OutlineButtonWidget> createState() => _OutlineButtonWidgetState();
}

class _OutlineButtonWidgetState extends State<OutlineButtonWidget> {
  late Color _shadowColor;

  bool _isPressed = false;

  bool get _isDisabled => widget.onPressed == null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeColors();
  }

  void _initializeColors() {
    final buttonStyle = OutlinedButtonTheme.of(context).style;
    final borderSide = buttonStyle?.side?.resolve({});
    final borderColor = borderSide?.color ?? Theme.of(context).colorScheme.outline;

    _shadowColor = borderColor.withValues(alpha: 0.5);
  }

  void _onTapDown(TapDownDetails _) => setState(() => _isPressed = true);

  void _onTapUp(TapUpDetails _) => setState(() => _isPressed = false);

  void _onTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _isDisabled ? null : _onTapDown,
      onTapUp: _isDisabled ? null : _onTapUp,
      onTapCancel: _isDisabled ? null : _onTapCancel,
      child: Transform.translate(
        offset: Offset(0, _isPressed ? widget.elevation : 0),
        child: Container(
          decoration: _buildShadowDecoration(),
          child: OutlinedButton(
            onPressed: widget.onPressed,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildShadowDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadiusResource.buttonBorderRadius,
      boxShadow:
          _isPressed || _isDisabled
              ? []
              : [
                BoxShadow(
                  color: _shadowColor,
                  offset: Offset(0, widget.elevation),
                  blurRadius: 0,
                ),
              ],
    );
  }
}
