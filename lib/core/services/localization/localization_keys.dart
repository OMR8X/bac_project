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
}

class _ButtonsKeys {
  final save = "general.buttons.save";
  final retry = "general.buttons.retry";
}
