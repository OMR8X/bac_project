// import '../api/api_manager.dart'ger.dart';
// import 'app_injection.dart';

import '../services/api/api_manager.dart';
import '../services/api/token_provider.dart';
import 'app_injection.dart';

clientInjection() async {
  sl.registerLazySingleton<TokenProvider>(() => SupabaseTokenProvider());
  sl.registerLazySingleton<ApiManager>(() => ApiManager(tokenProvider: sl<TokenProvider>()));
}
