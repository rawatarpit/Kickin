import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientProvider {
  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    const url = String.fromEnvironment('SUPABASE_URL');
    const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

    if (url.isEmpty || anonKey.isEmpty) {
      throw Exception(
        'Supabase environment variables are missing. '
        'Ensure SUPABASE_URL and SUPABASE_ANON_KEY are provided via --dart-define.',
      );
    }

    await Supabase.initialize(url: url, anonKey: anonKey);
  }
}
