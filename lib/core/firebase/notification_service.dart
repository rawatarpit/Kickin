import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationService {
  static final _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> stream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _db
        .collection('notifications')
        .doc(uid)
        .collection('items')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  static Stream<int> unreadCount() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _db
        .collection('notifications')
        .doc(uid)
        .collection('items')
        .where('seen', isEqualTo: false)
        .snapshots()
        .map((s) => s.size);
  }

  static Future<void> markSeen(String notificationId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _db.doc('notifications/$uid/items/$notificationId').update({
      'seen': true,
    });
  }
}
