import * as admin from "firebase-admin";
import {setGlobalOptions} from "firebase-functions/v2";

setGlobalOptions({region: "asia-south1"});

admin.initializeApp();

export {onLikeCreate} from "./notifications/on_like";
export {onCommentCreate} from "./notifications/on_comment";
export {onFollowCreate} from "./notifications/on_follow";
