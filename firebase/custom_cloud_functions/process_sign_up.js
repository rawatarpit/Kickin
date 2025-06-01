const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

const { getAuth } = require("firebase-admin/auth");
const { createClient } = require("@supabase/supabase-js");

// Logger implementation
const Logger = {
  timestamp: () => new Date().toISOString(),
  formatMessage: (level, message, meta = {}) => {
    return JSON.stringify({
      timestamp: Logger.timestamp(),
      level,
      message,
      ...meta,
    });
  },
  info: (message, meta) => {
    console.log(Logger.formatMessage("INFO", message, meta));
  },
  error: (message, error, meta) => {
    console.error(
      Logger.formatMessage("ERROR", message, {
        ...meta,
        error: error
          ? {
              message: error.message,
              stack: error.stack,
              name: error.name,
            }
          : undefined,
      }),
    );
  },
  debug: (message, meta) => {
    console.log(Logger.formatMessage("DEBUG", message, meta));
  },
};

async function createUserInSupabase(user, supabase) {
  Logger.debug("Creating user in Supabase", {
    firebaseUid: user.uid,
  });

  try {
    ///////////////////////////////////////////
    //Modify this to match your Supabase Schema
    const { data: newUser, error: insertError } = await supabase
      .from("users")
      .insert([
        {
          user_id: user.user_id,
          email: user.email,
          name: user.name || null,
          phone: user.phone || null,
        },
      ])
      .select()
      .single();

    if (insertError) {
      throw insertError;
    }

    Logger.info("Successfully created user in Supabase", {
      userId: newUser.id,
    });
    return newUser.id;
  } catch (error) {
    Logger.error("Failed to create user", error);
    throw error;
  }
}

exports.processSignUp = functions.auth.user().onCreate(async (user) => {
  Logger.debug("Processing new user signup", {
    uid: user.uid,
    email: user.email,
  });

  try {
    // Set custom user claims
    Logger.debug("Setting custom user claims");
    await getAuth().setCustomUserClaims(user.uid, { role: "authenticated" });

    // Get Supabase config from environment variables
    const supabaseUrl = functions.config().supabase.url;
    const supabaseKey = functions.config().supabase.key;
    const supabase = createClient(supabaseUrl, supabaseKey);

    // Ensure user exists in Supabase
    const userId = await createUserInSupabase(user, supabase);

    Logger.info("Successfully processed user signup", {
      userId,
      hasEmail: !!user.email,
      hasPhone: !!user.phoneNumber,
    });

    return { success: true };
  } catch (error) {
    Logger.error("Error in processSignUp", error);
    throw error;
  }
});
