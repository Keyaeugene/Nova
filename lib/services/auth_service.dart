import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  static const String webClientId =
      '947871175462-lihtel80at1sm3bbtk5scp9aif4ct4f7.apps.googleusercontent.com';
  static const String iosClientId =
      '947871175462-emsfepn75cokujofl20hjf14cds2a0m4.apps.googleusercontent.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb ? webClientId : (Platform.isIOS ? iosClientId : null),
    serverClientId: webClientId,
  );

  Future<AuthResponse> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Google sign-in canceled or failed.';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      // Sign in with Supabase using Google credentials
      final AuthResponse authResponse =
          await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      // Fetch the signed-in user's info
      final User? user = authResponse.session?.user;

      if (user != null) {
        await _updateUserInfo(user, googleUser);
      } else {
        throw 'Failed to retrieve user after Google sign-in.';
      }

      return authResponse;
    } catch (e) {
      print('Error during Google Sign-In: $e');
      rethrow;
    }
  }

  Future<void> _updateUserInfo(
      User supabaseUser, GoogleSignInAccount googleUser) async {
    final String googleUserEmail = supabaseUser.email ?? googleUser.email;
    final String googleUserName = supabaseUser.userMetadata?['full_name'] ??
        googleUser.displayName ??
        googleUserEmail ??
        'Unknown';
    final String googleAvatarUrl = supabaseUser.userMetadata?['avatar_url'] ??
        googleUser.photoUrl ??
        'default_avatar_url_here';

    if (googleUserEmail != null) {
      try {
        await Supabase.instance.client.from('users').upsert({
          'id': supabaseUser.id,
          'full_name': googleUserName,
          'email': googleUserEmail,
          'avatar_url': googleAvatarUrl,
          'google': googleUserEmail,
          'created_at': DateTime.now().toIso8601String(),
        });
      } catch (e) {
        print('Error updating user info in Supabase: $e');
        // Consider how you want to handle this error. You might want to:
        // - Notify the user
        // - Try again
        // - Log it for later analysis
      }
    } else {
      print('Warning: Unable to update user info - email is null');
    }
  }
}
