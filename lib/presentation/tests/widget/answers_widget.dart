// ignore_for_file: must_be_immutable

import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/presentation/tests/widget/radio_answer_widget.dart';
import 'package:flutter/material.dart';

class AnswersWidget extends StatefulWidget {
  const AnswersWidget({super.key});

  @override
  State<AnswersWidget> createState() => _AnswersWidgetState();
}

class _AnswersWidgetState extends State<AnswersWidget> {
  String _selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioAnswerWidget(
          val: '1',
          text: '1',
          onChanged: (val) {
            setState(() {
                _selectedValue = val!;
            });
          },

          groupValue: _selectedValue,
        ),
        //
        Padding(padding: PaddingResources.padding_0_3),
        //
        RadioAnswerWidget(
          val: '2',
          text: '2',
          onChanged: (val) {
            setState(() {
                _selectedValue = val!;
            });
          },
          groupValue: _selectedValue,
        ),
        //
        Padding(padding: PaddingResources.padding_0_3),
        //
        RadioAnswerWidget(
          val: '3',
          text: '3',
          onChanged: (val) {
            setState(() {
                _selectedValue = val!;
            });
          },
          groupValue: _selectedValue,
        ),
        //
        Padding(padding: PaddingResources.padding_0_3),
        //
        RadioAnswerWidget(
          val: '4',
          text: '4',
          onChanged: (val) {
            setState(() {
                _selectedValue = val!;
            });
          },
          groupValue: _selectedValue,
        ),
      ],
    );
  }
}
