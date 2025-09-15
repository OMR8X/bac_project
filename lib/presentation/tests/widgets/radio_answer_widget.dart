import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';

class RadioAnswerWidget extends StatelessWidget {
  const RadioAnswerWidget({
    super.key,
    required this.val,
    required this.text,
    required this.onChanged,
    required this.groupValue,
  });
  final String val;
  final String text;
  final void Function(String?) onChanged;
  final String groupValue;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: val,
      onChanged: onChanged,
      title: Text('Answer $text', style: TextStyle(fontSize: 14)),
      activeColor: Theme.of(context).colorScheme.primary,
      groupValue: groupValue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5),
        side: BorderSide(
          width: (groupValue == val ? 2 : 0),
          color:
              (groupValue == val
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),

      radioScaleFactor: 0.8,
      contentPadding: Paddings.zero,
      dense: true,
    );
  }
}
