import 'package:google_sign_in/google_sign_in.dart';
import 'package:nova/main.dart';
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
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}
