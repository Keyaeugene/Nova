import 'package:flutter/material.dart';
import 'package:nova/main.dart';
import 'package:nova/pages/login_page.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.grey[300],
    centerTitle: true,
    title: const Text(
      "Settings",
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
  );
}

Widget settingsButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await supabase.auth.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }
                },
                child: const Text('Confirm'),
              )
            ],
          );
        },
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Row(
        children: [
          const Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 50,
            child: Container(
              height: 30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage("lib/images/logout.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
