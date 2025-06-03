class LocalizationKeys {
  LocalizationKeys._();

  static final auth = _AuthKeys();
  static final home = _HomeKeys();
  static final bottomNavigationBar = _BottonNavigationBar();
  static final settings = _SettingsKeys();
  static final result = _ResultKeys();
  static final search = _SearchKeys();
}

class _AuthKeys {
  final signIn = 'auth.sign_in';
  final signUp = 'auth.sign_up';
  final email = 'auth.email';
  final password = 'auth.password';
}

class _HomeKeys {
  final card = _CardHomeKeys();
  final title = 'home.title';
}

class _CardHomeKeys {
  final title = 'home.card.title';
  final subtitle = 'home.card.subtitle';
  final firstButtonText = 'home.card.firstButtonText';
  final secondButtonText = 'home.card.secondButtonText';
}

class _SettingsKeys {
  final title = 'setting.title';
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
