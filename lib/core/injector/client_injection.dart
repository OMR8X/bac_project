// import '../api/api_manager.dart'ger.dart';
// import 'app_injection.dart';

import '../services/api/api_manager.dart';
import 'app_injection.dart';

clientInjection() async {
  sl.registerLazySingleton<ApiManager>(() => ApiManager());
}
