import 'package:flutter/material.dart';
import 'package:nova/components/text_box.dart';
import 'package:nova/widgets/settings_widget.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../provider/user_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final currentUser = Supabase.instance.client.auth.currentUser;

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // Cancel Button
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // Save Button
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop(newValue);
            },
          ),
        ],
      ),
    );

    // Update in Supabase
    if (newValue.trim().isNotEmpty) {
      await Supabase.instance.client
          .from('users')
          .update({field: newValue}).eq('id', currentUser!.id);

      // Update the provider when the full name is changed
      if (field == 'full_name') {
        Provider.of<UserProvider>(context, listen: false).setFullName(newValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: buildAppBar(),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client
            .from('users')
            .stream(primaryKey: ['id']).eq('id', currentUser!.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Check if the list is not empty before accessing the first element
            if (snapshot.data!.isNotEmpty) {
              final userData = snapshot.data!.first;

              return ListView(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    currentUser!.email!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      'Edit my details',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  MyTextBox(
                    text: userData['full_name'] ?? 'No username',
                    sectionName: 'Full name',
                    onPressed: () => editField('full_name'),
                  ),
                  MyTextBox(
                    text: userData['email'] ?? 'No email',
                    sectionName: 'Email',
                    onPressed: () => editField('email'),
                  ),
                  if (userData['provider'] == 'google') ...[
                    MyTextBox(
                      text: userData['google'] ?? 'No Google email',
                      sectionName: 'Google Email',
                      onPressed: () {}, // Google email should not be editable
                    ),
                  ],
                  const SizedBox(height: 50),
                  Center(child: settingsButton(context)),
                ],
              );
            } else {
              // Handle the case where no data is found
              return const Center(
                child: Text('No user data found.'),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
