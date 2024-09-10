import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider with ChangeNotifier {
  String fullName = '';
  String email = '';
  String avatarUrl = '';
  String provider = '';

  Future<void> fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      // Check if user is signed in via Google
      if (user.appMetadata['provider'] == 'google') {
        fullName = user.userMetadata?['full_name'] ?? 'No full name';
        email = user.email ?? 'No email';
        avatarUrl = user.userMetadata?['avatar_url'] ?? '';
        provider = 'google';
      } else {
        // Handle data fetching from your users table if not Google sign-in
        final response = await Supabase.instance.client
            .from('users')
            .select()
            .eq('id', user.id)
            .single();

        fullName = response['full_name'] ?? 'No full name';
        email = response['email'] ?? 'No email';
        avatarUrl = response['avatar_url'] ?? '';
        provider = response['provider'] ?? 'email';
      }
      notifyListeners();
    }
  }

  void setFullName(String name) {
    fullName = name;
    notifyListeners();
  }

  void setEmail(String emailAddress) {
    email = emailAddress;
    notifyListeners();
  }

  void setAvatarUrl(String url) {
    avatarUrl = url;
    notifyListeners();
  }

  void setProvider(String signInProvider) {
    provider = signInProvider;
    notifyListeners();
  }
}
