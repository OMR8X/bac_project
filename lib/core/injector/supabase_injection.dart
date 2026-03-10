import 'package:neuro_app/core/injector/tests_feature_inj.dart';
import 'package:neuro_app/core/services/api/supabase/supabase_settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> supabaseInjection() async {
  await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}
