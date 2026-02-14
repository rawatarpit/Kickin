import {onDocumentCreated} from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";

export const onLikeCreate = onDocumentCreated(
  "posts/{postId}/likes/{userId}",
  async (event) => {
    const postId = event.params.postId;
    const likerId = event.params.userId;

    const postSnap = await admin
      .firestore()
      .collection("posts")
      .doc(postId)
      .get();

    if (!postSnap.exists) return;

    const post = postSnap.data()!;
    if (post.userId === likerId) return;

    const userSnap = await admin
      .firestore()
      .collection("users")
      .doc(likerId)
      .get();

    if (!userSnap.exists) return;

    const user = userSnap.data()!;

    await admin
      .firestore()
      .collection("notifications")
      .doc(post.userId)
      .collection("items")
      .add({
        type: "like",
        fromUserId: likerId,
        fromUsername: user.username,
        fromUserImage: user.userImage ?? "",
        postId,
        seen: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
  }
);
