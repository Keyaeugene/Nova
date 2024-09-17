import 'package:flutter/material.dart';
import 'package:nova/provider/user_provider.dart';
import 'package:provider/provider.dart';

AppBar buildAppBar(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);

  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Nova",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        ClipOval(
          child: userProvider.avatarUrl.isNotEmpty
              ? Image.network(
                  userProvider.avatarUrl, // Use avatarUrl from UserProvider
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'lib/images/head.png', // Fallback image
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    );
                  },
                )
              : Image.asset(
                  'lib/images/head.png', // Fallback image
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
        ),
      ],
    ),
    centerTitle: true,
    backgroundColor: Colors.grey[300],
  );
}
