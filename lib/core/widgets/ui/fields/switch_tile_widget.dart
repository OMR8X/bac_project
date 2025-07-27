import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SwitchTileWidget extends StatelessWidget {
  const SwitchTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.enabled,
    this.onChanged,
  });
  final String title;
  final String subtitle;
  final bool enabled;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Switch(
        value: enabled,
        onChanged: (value) async {
          onChanged?.call(value);
          await HapticFeedback.lightImpact();
        },
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
