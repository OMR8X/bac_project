import 'package:bac_project/core/extensions/build_context_l10n.dart';
  
import '../../../resources/styles/border_radius_resources.dart';
import '../../../resources/styles/font_styles_manager.dart';
import '../../../resources/styles/padding_resources.dart';
import 'package:flutter/material.dart';

class ModeSwitcherWidget extends StatefulWidget {
  const ModeSwitcherWidget({super.key, this.initialIsExploreMode = true, this.onModeChanged});

  final bool initialIsExploreMode;
  final ValueChanged<bool>? onModeChanged;

  @override
  State<ModeSwitcherWidget> createState() => _ModeSwitcherWidgetState();
}

class _ModeSwitcherWidgetState extends State<ModeSwitcherWidget>
    with SingleTickerProviderStateMixin {
  bool _isExploreMode = true;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  static const Duration _animationDuration = Duration(milliseconds: 200);
  static const Curve _animationCurve = Curves.easeInOutCubic;

  @override
  void initState() {
    super.initState();
    _isExploreMode = widget.initialIsExploreMode;
    _initializeAnimations();
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
    setState(() {
      _isExploreMode = !_isExploreMode;
    });

    // Notify parent widget about the change
    widget.onModeChanged?.call(_isExploreMode);

    // Trigger scale animation
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  Widget _buildSlidingBackground(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: AnimatedAlign(
        alignment: _isExploreMode ? Alignment.centerLeft : Alignment.centerRight,
        duration: _animationDuration,
        curve: _animationCurve,
        child: Container(
          width: constraints.maxWidth / 2,
          height: constraints.maxHeight * 0.8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
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
        return AnimatedDefaultTextStyle(
          duration: _animationDuration,
          curve: _animationCurve,
          style: AppTextStyles.chipLabelStyle.copyWith(
            color:
                isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Icon(
                  iconData,
                  size: 18,
                  color:
                      isActive
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(width: 10),
              Text(text, style: AppTextStyles.button),
            ],
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
            "context.l10n.testPropertiesTabSwitcherExploreMode",
            _isExploreMode,
            Icons.explore,
          ),
        ),
        Expanded(
          child: _buildModeText(
            "context.l10n.testPropertiesTabSwitcherTestMode",
            !_isExploreMode,
            Icons.science,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitcherContainer() {
    return Container(
      height: 45,
      margin: PaddingResources.cardLargeTitlePadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadiusResource.buttonBorderRadius,
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
              _buildModeLabels(),
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
