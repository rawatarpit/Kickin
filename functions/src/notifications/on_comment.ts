import {onDocumentCreated} from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";

export const onCommentCreate = onDocumentCreated(
  "posts/{postId}/comments/{commentId}",
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const comment = snap.data() as {
      userId: string;
      username: string;
      userProfileImage?: string;
    };

    const postId = event.params.postId;

    const postSnap = await admin
      .firestore()
      .collection("posts")
      .doc(postId)
      .get();

    if (!postSnap.exists) return;

    const postOwnerId = postSnap.data()!.userId;

    // 🔒 prevent self notification
    if (postOwnerId === comment.userId) return;

    await admin
      .firestore()
      .collection("notifications")
      .doc(postOwnerId)
      .collection("items")
      .add({
        type: "comment",
        fromUserId: comment.userId,
        fromUsername: comment.username,
        fromUserImage: comment.userProfileImage ?? "",
        postId,
        seen: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
  }
);
