import 'package:flutter/material.dart';
import 'package:nova/main.dart';
import 'package:nova/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    final fullName =
        user?.userMetadata?['full_name'] ?? user?.userMetadata?['name'] ?? '';
    final profileImageUrl = user?.userMetadata?['avatar_url'] ??
        user?.userMetadata?['picture'] ??
        '';

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              ClipOval(
                child: profileImageUrl.isNotEmpty
                    ? Image.network(
                        profileImageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'lib/images/head.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 16),
              Text(
                fullName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: buildListView(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
