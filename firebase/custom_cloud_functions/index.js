const admin = require("firebase-admin/app");
admin.initializeApp();

const processSignUp = require("./process_sign_up.js");
exports.processSignUp = processSignUp.processSignUp;
