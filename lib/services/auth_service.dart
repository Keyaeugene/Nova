import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<AuthResponse> signInWithGoogle() async {
    const webClientId =
        '947871175462-lihtel80at1sm3bbtk5scp9aif4ct4f7.apps.googleusercontent.com';
    const iosClientId =
        '947871175462-emsfepn75cokujofl20hjf14cds2a0m4.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Google sign-in canceled or failed.';
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      // Sign in with Supabase using Google credentials
      final authResponse =
          await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      // Fetch the signed-in user's info
      final user = authResponse.session?.user;

      if (user != null) {
        final googleUserEmail = user.email;
        final googleUserName =
            user.userMetadata?['full_name'] ?? googleUserEmail;
        final googleAvatarUrl =
            user.userMetadata?['avatar_url'] ?? 'default_avatar_url_here';

        // Check if the user ID and email exist before upserting into the database
        if (googleUserEmail != null) {
          // Use upsert to insert or update user information in the 'users' table
          await Supabase.instance.client.from('users').upsert({
            'id': user.id,
            'full_name': googleUserName,
            'email': googleUserEmail,
            'avatar_url': googleAvatarUrl,
            'google': googleUserEmail,
            'created_at': DateTime.now().toIso8601String(),
          });
        } else {}
      } else {
        throw 'Failed to retrieve user after Google sign-in.';
      }

      return authResponse;
    } catch (e) {
      rethrow;
    }
  }
}
