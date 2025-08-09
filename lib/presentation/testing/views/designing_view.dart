import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/resources/themes/extensions/success_colors.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/presentation/tests/widget/question_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../features/tests/domain/entities/option.dart';
import '../../tests/widget/option_card_widget.dart';

class DesigningView extends StatefulWidget {
  const DesigningView({super.key});

  @override
  State<DesigningView> createState() => _DesigningViewState();
}

class _DesigningViewState extends State<DesigningView> {
  int? selectedOptionId;
  late Question question;
  @override
  void initState() {
    question = Question(
      id: 1,
      text:
          "السؤال الأول هو سؤال طويل يحتوي على عدة أسطر من النص لاختبار كيفية عرض النص الطويل في بطاقة السؤال والتأكد من أن التنسيق يعمل بشكل صحيح عندما يكون النص أطول من المعتاد ويحتاج إلى أكثر من سطر واحد للعرض",
      options: [
        Option(id: 1, text: "الخيار الذي يحتوي على الإجابة الصحيحة", isCorrect: true),
        Option(id: 2, text: "الخيار الذي يحتوي على الإجابة الخاطئة", isCorrect: false),
        Option(id: 3, text: "الخيار الذي يحتوي على الإجابة الخاطئة", isCorrect: false),
        Option(id: 4, text: "الخيار الذي يحتوي على الإجابة الخاطئة", isCorrect: false),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      body: Padding(
        padding: PaddingResources.screenSidesPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            QuestionCardWidget(question: question),
            OptionCardWidget(
              option: Option(id: 1, text: "الخيار الذي يحتوي على الإجابة الصحيحة", isCorrect: true),
              isSelected: selectedOptionId == 1,
              didAnswer: selectedOptionId != null,
              testMode: TestMode.exploring,
              onTap: (option) {
                if (selectedOptionId == option.id) {
                  setState(() {
                    selectedOptionId = null;
                  });
                  return;
                }
                setState(() {
                  selectedOptionId = option.id;
                });
              },
            ),
            OptionCardWidget(
              option: Option(
                id: 2,
                text: "الخيار الذي يحتوي على الإجابة الخاطئة",
                isCorrect: false,
              ),
              isSelected: selectedOptionId == 2,
              didAnswer: selectedOptionId != null,
              testMode: TestMode.exploring,
              onTap: (option) {
                if (selectedOptionId == option.id) {
                  setState(() {
                    selectedOptionId = null;
                  });
                  return;
                }
                setState(() {
                  selectedOptionId = option.id;
                });
              },
            ),
            OptionCardWidget(
              option: Option(
                id: 3,
                text: "الخيار الذي يحتوي على الإجابة الخاطئة",
                isCorrect: false,
              ),
              isSelected: selectedOptionId == 3,
              didAnswer: selectedOptionId != null,
              testMode: TestMode.exploring,
              onTap: (option) {
                if (selectedOptionId == option.id) {
                  setState(() {
                    selectedOptionId = null;
                  });
                  return;
                }
                setState(() {
                  selectedOptionId = option.id;
                });
              },
            ),
            OptionCardWidget(
              option: Option(
                id: 4,
                text: "الخيار الذي يحتوي على الإجابة الخاطئة",
                isCorrect: false,
              ),
              isSelected: selectedOptionId == 4,
              didAnswer: selectedOptionId != null,
              testMode: TestMode.exploring,
              onTap: (option) {
                if (selectedOptionId == option.id) {
                  setState(() {
                    selectedOptionId = null;
                  });
                  return;
                }
                setState(() {
                  selectedOptionId = option.id;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
