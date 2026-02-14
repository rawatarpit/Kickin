import {onDocumentCreated} from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";

export const onFollowCreate = onDocumentCreated(
  "followers/{userId}/items/{followerId}",
  async (event) => {
    const userId = event.params.userId;
    const followerId = event.params.followerId;

    const followerSnap = await admin
      .firestore()
      .collection("users")
      .doc(followerId)
      .get();

    if (!followerSnap.exists) return;

    const follower = followerSnap.data()!;

    await admin
      .firestore()
      .collection("notifications")
      .doc(userId)
      .collection("items")
      .add({
        type: "follow",
        fromUserId: followerId,
        fromUsername: follower.username,
        fromUserImage: follower.userImage ?? "",
        postId: null,
        seen: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
  }
);
