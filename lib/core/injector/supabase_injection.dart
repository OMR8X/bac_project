import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> supabaseInjection() async {
  await Supabase.initialize(
    url: 'https://yyckcezjjzfxktiannbm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5Y2tjZXpqanpmeGt0aWFubmJtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQxNjM0ODMsImV4cCI6MjA2OTczOTQ4M30.GsrnUOoIsWls9kp82zfmUB-Rvy4T_0w7-F8L2RjEgKg',
  );
  sl.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );
}
