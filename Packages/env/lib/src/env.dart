// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, require_trailing_commas

enum Env {
  supabaseUrl('https://onqibefuwhbwcaesddud.supabase.co'),
  powerSyncUrl('https://67657037c759bf1acc2156c5.powersync.journeyapps.com'),
  iOSClientId('IOS_CLIENT_ID'),
  webClientId('WEB_CLIENT_ID'),
  fcmServerKey('FCM_SERVER_KEY'),
  supabaseAnonKey(
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9ucWliZWZ1d2hid2NhZXNkZHVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ2MTI2NTIsImV4cCI6MjA1MDE4ODY1Mn0.V3zAz0IvZaoZnlW9xJgqkj70nBGvUBw2x13g9uNCUYY');

  const Env(this.value);

  final String value;
}
