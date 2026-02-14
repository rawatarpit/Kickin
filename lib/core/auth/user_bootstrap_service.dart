import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

import '../supabase/rpc_service.dart';
import '../supabase/identity_service.dart';
import '../supabase/profile_service.dart';
import '../cache/profile_cache.dart';

class BootstrapResult {
  final bool profileComplete;
  final String uid;

  BootstrapResult({required this.profileComplete, required this.uid});
}

class UserBootstrapService {
  UserBootstrapService._();

  static Future<BootstrapResult> bootstrap() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('No authenticated user');
    }

    await user.getIdToken(true);

    // 1️⃣ Ensure user row exists
    await RpcService.ensureUserExists(firebaseUid: user.uid);

    // 2️⃣ Register device properly
    final fcmToken = await FirebaseMessaging.instance.getToken();

    final deviceId = await _getDeviceId();

    if (fcmToken != null) {
      await RpcService.registerDevice(
        firebaseUid: user.uid,
        fcmToken: fcmToken,
        deviceId: deviceId,
      );
    }

    // 3️⃣ Profile completion check
    final isComplete = await IdentityService.isProfileComplete(user.uid);

    if (isComplete) {
      final profile = await ProfileService.fetchProfile(user.uid);

      ProfileCache.set(user.uid, profile.toJson());
    }

    return BootstrapResult(profileComplete: isComplete, uid: user.uid);
  }

  static Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      final web = await deviceInfo.webBrowserInfo;
      return web.userAgent ?? 'web';
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = await deviceInfo.androidInfo;
      return android.id;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final ios = await deviceInfo.iosInfo;
      return ios.identifierForVendor ?? 'ios';
    }

    return 'unknown';
  }
}
