import 'dart:ui';
import 'package:neuro_app/core/injector/results_feature_inj.dart';
import 'package:neuro_app/core/resources/styles/spaces_resources.dart';
import 'package:neuro_app/core/resources/styles/spacing_resources.dart';
import 'package:neuro_app/core/resources/styles/font_styles_manager.dart';
import 'package:neuro_app/core/resources/styles/border_radius_resources.dart';
import 'package:neuro_app/core/services/codepush/codepush_manager.dart';
import 'package:neuro_app/features/tests/domain/entities/option.dart';
import 'package:neuro_app/features/tests/domain/entities/question.dart';
import 'package:neuro_app/features/tests/domain/entities/question_answer.dart';
import 'package:neuro_app/features/tests/domain/entities/test_mode.dart';
import 'package:neuro_app/presentation/quizzing/widgets/multiple_choices_options_builder_widget.dart';
import 'package:neuro_app/presentation/quizzing/widgets/textual_options_builder_widget.dart';
import 'package:neuro_app/presentation/quizzing/widgets/Orderable_options_builder_widget.dart';
import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/messages/snackbars/alert_snackbar_widget.dart';
import '../../../core/widgets/messages/snackbars/informations_snackbar_widget.dart';
import '../../../core/widgets/messages/snackbars/success_snackbar_widget.dart';
import '../../../core/widgets/messages/snackbars/error_snackbar_widget.dart';
import '../../../core/widgets/ui/icons/switch_theme_icon_widget.dart';
import '../../../core/widgets/buttons/filled_button_widget.dart';
import '../../../core/widgets/buttons/elevated_button_widget.dart';
import '../../../core/widgets/buttons/outline_button_widget.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/router/routes.dart';
import '../../../../core/services/router/app_arguments.dart';

import '../../../../features/tests/domain/entities/lesson.dart';



// Prototypes
import 'prototypes/home_variation_a.dart';

class DesigningView extends StatefulWidget {
  const DesigningView({super.key});

  @override
  State<DesigningView> createState() => _DesigningViewState();
}

class _DesigningViewState extends State<DesigningView> with TickerProviderStateMixin {
  final int _currentIndex = 0;

  void _openPrototype(BuildContext context, String title, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prototypes'),
        actions: [
          SwitchThemeIconWidget(),
        ],
      ),
      body: Padding(
        padding: Paddings.screenSidesPadding,
        child: ListView(
          padding: Paddings.listViewPadding,
          children: [
            // Section: Home View Variations
            Padding(
              padding: EdgeInsets.only(bottom: SpacesResources.s4),
              child: Text(
                'Home View Variations',
                style: TextStylesResources.headline1.copyWith(color: cs.onSurface),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: SpacesResources.s6),
              child: Text(
                'اضغط على أي تصميم لتجربته',
                style: TextStylesResources.caption.copyWith(color: cs.onSurfaceVariant),
              ),
            ),
            _PrototypeButton(
              label: '🏠',
              title: 'Home View',
              subtitle: 'بطاقة السلسلة والتقدم + قائمة الدروس بتصميم الشريط الملون',
              color: const Color(0xFF2196F3),
              onTap: () => _openPrototype(context, 'Home', const HomeVariationA()),
            ),

            // Divider
            Padding(
              padding: EdgeInsets.symmetric(vertical: SpacesResources.s6),
              child: Divider(color: cs.outlineVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrototypeButton extends StatelessWidget {
  const _PrototypeButton({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final String label;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: SpacesResources.s3),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          onTap: onTap,
          child: Padding(
            padding: Paddings.cardMediumPadding,
            child: Row(
              children: [
                // Label badge
                Container(
                  width: SpacesResources.s16,
                  height: SpacesResources.s16,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadiusResource.bordersRadiusSmall,
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStylesResources.cardMediumTitle.copyWith(
                        color: color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: SpacesResources.s4),
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStylesResources.cardMediumTitle.copyWith(
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: SpacesResources.s1),
                      Text(
                        subtitle,
                        style: TextStylesResources.caption.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_left, color: cs.onSurfaceVariant, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TestCodepushFunctionality extends StatelessWidget {
  const TestCodepushFunctionality({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await sl<CodePushManager>()().initialize();
            },
            child: const Text('Test Codepush Functionality'),
          ),
          ElevatedButton(
            onPressed: () async {},
            child: const Text('Siiii 2? 🙅'),
          ),
        ],
      ),
    );
  }
}

class TestButtonsDesign extends StatelessWidget {
  const TestButtonsDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.screenBodyPadding,
      child: Center(
        child: Column(
          spacing: SpacesResources.s10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButtonWidget(onPressed: () {}, child: const Text('Filled Button')),
            ElevatedButtonWidget(onPressed: () {}, child: const Text('Elevated Button')),
            OutlineButtonWidget(onPressed: () {}, child: const Text('Outlined Button')),
            FilledButton(onPressed: () {}, child: const Text('Filled Button')),
            ElevatedButton(onPressed: () {}, child: const Text('Elevated Button')),
            OutlinedButton(onPressed: () {}, child: const Text('Outlined Button')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TestingNavBar extends StatelessWidget {
  const TestingNavBar(this.currentIndex, this.changePage, {super.key});
  final int currentIndex;
  final void Function(int pageIndex) changePage;

  @override
  Widget build(BuildContext context) {
    return CNTabBar(
      items: const [
        CNTabBarItem(label: 'Home', icon: CNSymbol('house.fill')),
        CNTabBarItem(label: 'Results', icon: CNSymbol('chart.bar.fill')),
        CNTabBarItem(label: 'Settings', icon: CNSymbol('gearshape.fill')),
      ],
      currentIndex: currentIndex,
      onTap: (i) => changePage(i),
    );
  }
}

class TestRichTextLinks extends StatelessWidget {
  const TestRichTextLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'اضغط ',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          // text with link
          TextSpan(
            text: 'هنا',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              decoration: TextDecoration.underline,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    print('Hello');
                  },
          ),
        ],
      ),
    );
  }
}

class ScrollTransitionAppBar extends StatefulWidget {
  const ScrollTransitionAppBar({super.key});

  @override
  State<ScrollTransitionAppBar> createState() => _ScrollTransitionAppBarState();
}

class _ScrollTransitionAppBarState extends State<ScrollTransitionAppBar> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final double offset = _scrollController.offset;
      final double maxScroll = 100.0; // Distance to complete transition
      setState(() {
        _scrollProgress = (offset / maxScroll).clamp(0.0, 1.0);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AnimatedScrollAppBar(
        title: "My Files",
        scrollController: _scrollController,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
            tooltip: 'More options',
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        itemCount: 30,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text('Item $i'),
            subtitle: Text('Description for item $i'),
            leading: CircleAvatar(
              child: Text('${i + 1}'),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}

/// A reusable animated app bar that transitions smoothly on scroll
///
/// Features:
/// - Title moves from center to left on scroll
/// - Background becomes translucent with blur effect
/// - Actions fade out smoothly
///
/// Usage:
/// ```dart
/// final ScrollController _scrollController = ScrollController();
///
/// Scaffold(
///   extendBodyBehindAppBar: true,
///   appBar: AnimatedScrollAppBar(
///     title: "My Title",
///     scrollController: _scrollController,
///     actions: [IconButton(...)],
///   ),
///   body: ListView(
///     controller: _scrollController,
///     padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
///     children: [...],
///   ),
/// )
/// ```
class AnimatedScrollAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final ScrollController scrollController;
  final List<Widget>? actions;
  final double maxScrollDistance;

  const AnimatedScrollAppBar({
    super.key,
    required this.title,
    required this.scrollController,
    this.actions,
    this.maxScrollDistance = 100.0,
  });

  @override
  State<AnimatedScrollAppBar> createState() => _AnimatedScrollAppBarState();

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}

class _AnimatedScrollAppBarState extends State<AnimatedScrollAppBar> {
  double _scrollProgress = 0.0;
  bool _isSnapping = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(AnimatedScrollAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_onScroll);
      widget.scrollController.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients || _isSnapping) return;

    final double offset = widget.scrollController.offset;
    final double progress = (offset / widget.maxScrollDistance).clamp(0.0, 1.0);

    if (_scrollProgress != progress) {
      setState(() {
        _scrollProgress = progress;
      });
    }

    // Check if user stopped scrolling to trigger snap
    _scheduleSnapCheck();
  }

  void _scheduleSnapCheck() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted || _isSnapping) return;

      // Check if scroll has stopped
      if (widget.scrollController.hasClients &&
          widget.scrollController.position.activity?.isScrolling == false) {
        _snapScrollPosition();
      }
    });
  }

  Future<void> _snapScrollPosition() async {
    if (_isSnapping || !mounted || !widget.scrollController.hasClients) return;

    final double currentOffset = widget.scrollController.offset;

    // Only snap if within the snap range (0 to maxScrollDistance)
    if (currentOffset < 0 || currentOffset > widget.maxScrollDistance) return;

    // Determine target position based on current progress
    final double targetOffset = _scrollProgress < 0.5 ? 0.0 : widget.maxScrollDistance;

    // If already at target, no need to animate
    if ((currentOffset - targetOffset).abs() < 1.0) return;

    _isSnapping = true;

    try {
      // Animate the ListView scroll position
      await widget.scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    } finally {
      if (mounted) {
        _isSnapping = false;
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: lerpDouble(0, 10, _scrollProgress)!,
            sigmaY: lerpDouble(0, 10, _scrollProgress)!,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(
                lerpDouble(1.0, 0.4, Curves.easeIn.transform(_scrollProgress))!,
              ),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(
                    lerpDouble(0.0, 0.1, Curves.easeIn.transform(_scrollProgress))!,
                  ),
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
      title: AnimatedAppBarTitle(
        title: widget.title,
        scrollProgress: _scrollProgress,
      ),
      actions:
          widget.actions != null
              ? [
                AnimatedAppBarIcons(
                  scrollProgress: _scrollProgress,
                  children: widget.actions!,
                ),
              ]
              : null,
    );
  }
}

class AnimatedAppBarTitle extends StatelessWidget {
  final String title;
  final double scrollProgress;

  const AnimatedAppBarTitle({
    super.key,
    required this.title,
    required this.scrollProgress,
  });

  @override
  Widget build(BuildContext context) {
    // Smooth curves for different properties
    final double positionProgress = Curves.easeInOutCubic.transform(scrollProgress);
    final double sizeProgress = Curves.easeOutCubic.transform(scrollProgress);

    // Font size: 20 -> 18 (subtle change)
    final double fontSize = lerpDouble(20, 18, sizeProgress)!;

    // Alignment: center (0.0) -> left (-1.0)
    final double alignment = lerpDouble(-0.0, 1.0, positionProgress)!;

    return Align(
      alignment: Alignment(alignment, 0.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}

class AnimatedAppBarIcons extends StatelessWidget {
  final double scrollProgress;
  final List<Widget> children;

  const AnimatedAppBarIcons({
    super.key,
    required this.scrollProgress,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    // Fade out and scale down
    final double opacity = (1.0 - Curves.easeInOut.transform(scrollProgress)).clamp(0.0, 1.0);
    final double scale = lerpDouble(1.0, 0.8, Curves.easeIn.transform(scrollProgress))!;

    return Opacity(
      opacity: opacity,
      child: IgnorePointer(
        ignoring: scrollProgress > 0.5,
        child: Transform.scale(
          scale: scale,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}

class TestSnackbars extends StatelessWidget {
  const TestSnackbars({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showAlertSnackbar(context: context, title: 'Test', subtitle: 'Test ' * 10);
          },
          child: Text('Show Alert Snackbar'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showInformationsSnackbar(context: context, title: 'Test', subtitle: 'Test ' * 10);
          },
          child: Text('Show Informations Snackbar'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showSuccessSnackbar(context: context, title: 'Test', subtitle: 'Test ' * 10);
          },
          child: Text('Show Success Snackbar'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showErrorSnackbar(context: context, title: 'Test', subtitle: 'Test ' * 10);
          },
          child: Text('Show Error Snackbar'),
        ),
      ],
    );
  }
}

class TestOptionsDesign extends StatefulWidget {
  const TestOptionsDesign({super.key});

  @override
  State<TestOptionsDesign> createState() => _TestOptionsDesignState();
}

class _TestOptionsDesignState extends State<TestOptionsDesign> {
  late final Question multipleChoicesQuestion;
  late final Question textualQuestion;
  late final Question orderableQuestion;
  late final List<QuestionAnswer> questionsAnswers;
  @override
  void initState() {
    ///
    questionsAnswers = [
      // Multiple Choices Question
      QuestionAnswer(questionId: 1, optionId: 1, isCorrect: true),
      QuestionAnswer(questionId: 1, optionId: 2, isCorrect: false),

      // Orderable Question
      QuestionAnswer(questionId: 2, optionId: 1, answerText: 'Option 1', isCorrect: true),
      QuestionAnswer(questionId: 2, optionId: 2, answerText: 'Option 1', isCorrect: false),
      // Textual Question
      QuestionAnswer(questionId: 3, optionId: 1, answerPosition: 4, isCorrect: true),
      QuestionAnswer(questionId: 3, optionId: 2, answerPosition: 3, isCorrect: true),
      QuestionAnswer(questionId: 3, optionId: 3, answerPosition: 2, isCorrect: false),
      QuestionAnswer(questionId: 3, optionId: 4, answerPosition: 1, isCorrect: false),
    ];

    ///
    multipleChoicesQuestion = Question(
      id: 1,
      content: 'Multiple Choices Question',
      options: [
        Option(id: 1, questionId: 1, content: 'Option 1', isCorrect: true),
        Option(id: 2, questionId: 1, content: 'Option 2', isCorrect: false),
        Option(id: 3, questionId: 1, content: 'Option 3', isCorrect: false),
        Option(id: 4, questionId: 1, content: 'Option 4', isCorrect: false),
      ],
      lessonId: 1,
    );
    textualQuestion = Question(
      id: 2,
      content: 'Textual Question',
      options: [
        Option(id: 1, questionId: 2, content: 'Option 1', isCorrect: true),
        Option(id: 2, questionId: 2, content: 'Option 2', isCorrect: true),
        Option(id: 3, questionId: 2, content: 'Option 3', isCorrect: true),
        Option(id: 4, questionId: 2, content: 'Option 4', isCorrect: true),
      ],
      lessonId: 1,
    );
    orderableQuestion = Question(
      id: 3,
      content: 'Orderable Question',
      options: [
        Option(id: 1, questionId: 3, content: 'Option 1', isCorrect: true),
        Option(id: 2, questionId: 3, content: 'Option 2', isCorrect: true),
        Option(id: 3, questionId: 3, content: 'Option 3', isCorrect: true),
        Option(id: 4, questionId: 3, content: 'Option 4', isCorrect: true),
      ],
      lessonId: 1,
    );
    super.initState();
  }

  List<QuestionAnswer> _filterQuestionsAnswers(int questionId) {
    return questionsAnswers.where((answer) => answer.questionId == questionId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        MultipleChoicesQuestionBuilderWidget(
          question: multipleChoicesQuestion,
          questionsAnswers: _filterQuestionsAnswers(multipleChoicesQuestion.id),
          onSelectOption: (option) {
            ///
            questionsAnswers.removeWhere(
              (answer) => answer.questionId == multipleChoicesQuestion.id,
            );

            ///
            questionsAnswers.add(
              QuestionAnswer(questionId: multipleChoicesQuestion.id, optionId: option.id),
            );
            setState(() {});
          },
        ),
        TextualQuestionsBuilderWidget(
          // testMode: TestMode.testing,
          question: textualQuestion,
          questionsAnswers: _filterQuestionsAnswers(textualQuestion.id),
          onSubmitText: (option, value) {
            ///
            questionsAnswers.removeWhere((answer) {
              return answer.questionId == textualQuestion.id && answer.optionId == option.id;
            });

            ///
            questionsAnswers.add(
              QuestionAnswer(
                questionId: textualQuestion.id,
                answerText: value,
                optionId: option.id,
              ),
            );
            setState(() {});
          },
        ),
        OrderableQuestionBuilderWidget(
          testMode: TestMode.testing,
          question: orderableQuestion,
          questionsAnswers: _filterQuestionsAnswers(orderableQuestion.id),
          onSubmitOrder: (options) {
            ///
            questionsAnswers.removeWhere((answer) {
              return answer.questionId == orderableQuestion.id;
            });

            ///
            questionsAnswers.addAll(
              List.generate(
                options.length,
                (index) => QuestionAnswer(
                  questionId: orderableQuestion.id,
                  answerPosition: index,
                  optionId: options[index].id,
                ),
              ),
            );
            setState(() {});
          },
        ),
      ],
    );
  }
}
