import '../../../resources/styles/border_radius_resources.dart';
import '../../../resources/styles/font_styles_manager.dart';
import '../../../resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';

class SwitchOption<T> {
  const SwitchOption({required this.value, required this.label, required this.icon});

  final T value;
  final String label;
  final IconData icon;
}

class ModeSwitcherWidget<T> extends StatefulWidget {
  const ModeSwitcherWidget({
    super.key,
    required this.firstOption,
    required this.secondOption,
    required this.currentValue,
    this.onChanged,
  });

  final SwitchOption<T> firstOption;
  final SwitchOption<T> secondOption;
  final T currentValue;
  final ValueChanged<T>? onChanged;

  @override
  State<ModeSwitcherWidget<T>> createState() => _ModeSwitcherWidgetState<T>();
}

class _ModeSwitcherWidgetState<T> extends State<ModeSwitcherWidget<T>>
    with SingleTickerProviderStateMixin {
  late T _currentValue;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  static const Duration _animationDuration = Duration(milliseconds: 200);
  static const Curve _animationCurve = Curves.easeInOutCubic;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentValue;
    _initializeAnimations();
  }

  @override
  void didUpdateWidget(ModeSwitcherWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentValue != widget.currentValue) {
      setState(() {
        _currentValue = widget.currentValue;
      });
    }
  }

  void _initializeAnimations() {
    _animationController = AnimationController(duration: _animationDuration, vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _animationController, curve: _animationCurve));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    final T newValue =
        _currentValue == widget.firstOption.value
            ? widget.secondOption.value
            : widget.firstOption.value;

    setState(() {
      _currentValue = newValue;
    });

    widget.onChanged?.call(newValue);

    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  bool get _isFirstSelected => _currentValue == widget.firstOption.value;

  Widget _buildSlidingBackground(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: AnimatedAlign(
        alignment:
            _isFirstSelected
                ? (Directionality.of(context) == TextDirection.rtl
                    ? Alignment.centerRight
                    : Alignment.centerLeft)
                : (Directionality.of(context) == TextDirection.rtl
                    ? Alignment.centerLeft
                    : Alignment.centerRight),
        duration: _animationDuration,
        curve: _animationCurve,
        child: Container(
          width: constraints.maxWidth / 2,
          height: constraints.maxHeight * 0.8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadiusResource.bordersRadiusTiny,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeText(String text, bool isActive, IconData iconData) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        final colorScheme = Theme.of(context).colorScheme;
        final activeColor = colorScheme.primary;
        final inactiveColor = colorScheme.onSurfaceVariant;

        return Transform.scale(
          scale: isActive ? _scaleAnimation.value : 1.0,
          child: AnimatedContainer(
            duration: _animationDuration,
            curve: _animationCurve,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: _animationDuration,
                  curve: _animationCurve,
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Icon(iconData, size: 18, color: isActive ? activeColor : inactiveColor),
                ),
                const SizedBox(width: 10),
                AnimatedDefaultTextStyle(
                  duration: _animationDuration,
                  curve: _animationCurve,
                  style: TextStylesResources.button.copyWith(
                    color: isActive ? activeColor : inactiveColor,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                  child: Text(text),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModeLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: _buildModeText(
            widget.firstOption.label,
            _isFirstSelected,
            widget.firstOption.icon,
          ),
        ),
        Expanded(
          child: _buildModeText(
            widget.secondOption.label,
            !_isFirstSelected,
            widget.secondOption.icon,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitcherContainer() {
    return Container(
      height: 45,
      margin: Paddings.cardLargeTitlePadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        // color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadiusResource.buttonBorderRadius,
        border: Border.all(color: Theme.of(context).colorScheme.outline, width: 0.75),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadiusResource.buttonBorderRadius,
          onTap: _toggleMode,
          child: Stack(
            alignment: Alignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return _buildSlidingBackground(constraints);
                },
              ),
              Padding(padding: const EdgeInsets.only(bottom: 2), child: _buildModeLabels()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: _buildSwitcherContainer());
  }
}
