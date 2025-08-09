class LocalizationKeys {
  LocalizationKeys._();

  static final auth = _AuthKeys();
  static final home = _HomeKeys();
  static final lessons = _LessonsKeys();
  static final bottomNavigationBar = _BottonNavigationBar();
  static final settings = _SettingsKeys();
  static final result = _ResultKeys();
  static final search = _SearchKeys();
  static final testProperties = _TestPropertiesKeys();
  static final buttons = _ButtonsKeys();
  static final pickLessons = _PickLessonsKeys();
}

class _PickLessonsKeys {
  final title = 'pick-lessons.title';
  final startTest = 'pick-lessons.start-test';
}

class _AuthKeys {
  final signIn = 'auth.sign_in';
  final signUp = 'auth.sign_up';
  final email = 'auth.email';
  final password = 'auth.password';
}

class _HomeKeys {
  final card = _CardHomeKeys();
  final quote = _QuoteKeys();
  final title = 'home.title';
}

class _LessonsKeys {
  final card = _CardHomeKeys();
  final title = 'lessons.title';
}

class _TestPropertiesKeys {
  final title = "test-properties.title";
  final answerVisibility = _AnswerVisibilityKeys();
  final enableSoundEffects = _SoundEffectsKeys();
  final questionsCount = _QuestionsCount();
  final tabSwitcher = _TabSwitcherKeys();
  final modes = _ModesKeys();
}

class _AnswerVisibilityKeys {
  final showTrueAnswerTitle = "test-properties.show-true-answer.title";
  final showTrueAnswerSubtitle = "test-properties.show-true-answer.subtitle";
}

class _SoundEffectsKeys {
  final title = "test-properties.enable-sound-effects.title";
  final subtitle = "test-properties.enable-sound-effects.subtitle";
}

class _QuestionsCount {
  final questionsCount = "test-properties.questions-count";
  final questionsCategories = "test-properties.questions-categories";
}

class _TabSwitcherKeys {
  final title = "test-properties.mode-switcher.title";
  final exploreMode = "test-properties.mode-switcher.explore-mode";
  final testMode = "test-properties.mode-switcher.test-mode";
}

class _ModesKeys {
  final exploreMode = _ExploreModeKeys();
  final testMode = _TestModeKeys();
  final customMode = _CustomModeKeys();
}

class _ExploreModeKeys {
  final title = "test-properties.modes.explore-mode.title";
  final subtitle = "test-properties.modes.explore-mode.subtitle";
  final description = "test-properties.modes.explore-mode.description";
}

class _TestModeKeys {
  final title = "test-properties.modes.test-mode.title";
  final subtitle = "test-properties.modes.test-mode.subtitle";
  final description = "test-properties.modes.test-mode.description";
}

class _CustomModeKeys {
  final title = "test-properties.modes.custom-mode.title";
  final subtitle = "test-properties.modes.custom-mode.subtitle";
  final description = "test-properties.modes.custom-mode.description";
}

class _CardHomeKeys {
  final startTestAction = 'home.card.start-test-action';
  final exploreLessonsAction = 'home.card.explore-lessons-action';
}

class _SettingsKeys {
  final title = 'setting.title';
}

class _QuoteKeys {
  final dailyQuote = 'home.quote.daily-quote';
  final expandQuote = 'home.quote.expand-quote';
}

class _ResultKeys {
  final title = 'result.title';
}

class _BottonNavigationBar {
  final home = 'navigation.home';
  final results = 'navigation.results';
  final settings = 'navigation.settings';
}

class _SearchKeys {
  final hint = 'search.hint';
  final title = 'search.title';
  final noResults = 'search.no-results';
}

class _ButtonsKeys {
  final save = "general.buttons.save";
  final next = "general.buttons.next";
  final confirm = "general.buttons.confirm";
  final customize = "general.buttons.customize";
  final retry = "general.buttons.retry";
  final pick = "general.buttons.pick";
  final previous = "general.buttons.previous";
  final finish = "general.buttons.finish";
  final result = "general.buttons.result";
  final close = "general.buttons.close";
}
