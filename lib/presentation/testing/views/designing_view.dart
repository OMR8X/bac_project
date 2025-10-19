import 'dart:ui';
import 'dart:math' as math;
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/presentation/quizzing/widgets/multiple_choices_options_builder_widget.dart';
import 'package:bac_project/presentation/quizzing/widgets/textual_options_builder_widget.dart';
import 'package:bac_project/presentation/quizzing/widgets/Orderable_options_builder_widget.dart';
import 'package:bac_project/presentation/tests/widgets/question_card_widget.dart';
import 'package:collection/collection.dart';
import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/widgets/messages/snackbars/alert_snackbar_widget.dart';
import '../../../core/widgets/messages/snackbars/informations_snackbar_widget.dart';
import '../../../core/widgets/messages/snackbars/success_snackbar_widget.dart';
import '../../../core/widgets/messages/snackbars/error_snackbar_widget.dart';
import '../../../core/widgets/ui/icons/switch_theme_icon_widget.dart';

class DesigningView extends StatefulWidget {
  const DesigningView({super.key});

  @override
  State<DesigningView> createState() => _DesigningViewState();
}

class _DesigningViewState extends State<DesigningView> with TickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Designing'),
        actions: [
          SwitchThemeIconWidget(),
        ],
      ),
      body: Stack(
        children: [
          // List of images
          ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return Image.network(
                'https://picsum.photos/400/300?random=$index',
                height: 200,
                fit: BoxFit.cover,
              );
            },
          ),
          // Top navbar
          Align(
            alignment: Alignment.bottomCenter,
            child: TestingNavBar(_currentIndex, (index) {
              setState(() {
                _currentIndex = index;
              });
            }),
          ),
          // Bottom navbar
        ],
      ),
    );
  }
}

class TestingNavBar extends StatelessWidget {
  const TestingNavBar(this.currentIndex, this.changePage);
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
            showAlertSnackbar(context: context, title: 'Test', subtitle: 'Test');
          },
          child: Text('Show Alert Snackbar'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showInformationsSnackbar(context: context, title: 'Test', subtitle: 'Test');
          },
          child: Text('Show Informations Snackbar'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showSuccessSnackbar(context: context, title: 'Test', subtitle: 'Test');
          },
          child: Text('Show Success Snackbar'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showErrorSnackbar(context: context, title: 'Test', subtitle: 'Test');
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
