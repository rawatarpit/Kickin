import 'package:chats_repository/chats_repository.dart';
import 'package:database_client/database_client.dart';
import 'package:env/env.dart';
import 'package:firebase_notifications_client/firebase_notifications_client.dart';
import 'package:kickin/app/app.dart';
import 'package:kickin/bootstrap.dart'; 
import 'package:notifications_repository/notifications_repository.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:search_repository/search_repository.dart';
import 'package:shared/shared.dart';
import 'package:stories_repository/stories_repository.dart';
import 'package:supabase_authentication_client/supabase_authentication_client.dart';
import 'package:token_storage/token_storage.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    appFlavor: AppFlavor
        EnvDev; // Update to your environment (development/production)
    (
      supabaseClient,
      firebaseMessaging,
      sharedPreferences,
    ) async {
      // Initialize Firebase Notifications
      final firebaseNotificationsClient = FirebaseNotificationsClient(
        firebaseMessaging: firebaseMessaging,
      );

      final notificationsRepository = NotificationsRepository(
        notificationsClient: firebaseNotificationsClient,
      );

      // Token Storage (e.g., In-Memory Storage for OAuth tokens)
      final tokenStorage = InMemoryTokenStorage();

      // Environment Variables
      final appFlavor = AppFlavor.production();
      final iosClientId = appFlavor.getEnv(Env.iOSClientId);
      final webClientId = appFlavor.getEnv(Env.webClientId);

      // Google Sign-In Configuration
      final googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );

      // Supabase Authentication Client
      final authenticationClient = SupabaseAuthenticationClient(
        supabaseClient: supabaseClient,
        tokenStorage: tokenStorage,
        googleSignIn: googleSignIn,
      );

      // Supabase Database Client
      final databaseClient =
          SupabaseDatabaseClient(supabaseClient: supabaseClient);

      // Persistent Storage
      final persistentStorage = PersistentStorage(
        sharedPreferences: sharedPreferences,
      );

      // Stories Storage
      final storiesStorage = StoriesStorage(storage: persistentStorage);

      // Repositories
      final userRepository = UserRepository(
        databaseClient: databaseClient,
        authenticationClient: authenticationClient,
      );

      final searchRepository = SearchRepository(databaseClient: databaseClient);

      final postsRepository = PostsRepository(databaseClient: databaseClient);

      final chatsRepository = ChatsRepository(databaseClient: databaseClient);

      final storiesRepository = StoriesRepository(
        databaseClient: databaseClient,
        storage: storiesStorage,
      );

      // Kickin App Entry Point
      return App(
        userRepository: userRepository,
        postsRepository: postsRepository,
        chatsRepository: chatsRepository,
        storiesRepository: storiesRepository,
        searchRepository: searchRepository,
        notificationsRepository: notificationsRepository,
        user: await userRepository.user.first,
      );
    },
  );
}
