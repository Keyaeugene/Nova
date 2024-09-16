import 'package:flutter/material.dart';
import 'package:nova/pages/home_page.dart';
import 'package:nova/pages/profile_page.dart';

Widget buildPage(int index) {
  List<Widget> widget = [
    const HomePage(),
    const Center(child: Text("Favorite")),
    const Center(child: Text("search")),
    const ProfilePage(),
  ];
  return widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "Home",
    icon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset("lib/images/home.png"),
    ),
    activeIcon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset(
        "lib/images/home.png",
        color: const Color.fromARGB(255, 3, 175, 248),
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Favorites",
    icon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset("lib/images/favorite.png"),
    ),
    activeIcon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset(
        "lib/images/favorite.png",
        color: const Color.fromARGB(255, 3, 175, 248),
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Search",
    icon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset("lib/images/search.png"),
    ),
    activeIcon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset(
        "lib/images/search.png",
        color: const Color.fromARGB(255, 3, 175, 248),
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Profile",
    icon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset("lib/images/profile.png"),
    ),
    activeIcon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset(
        "lib/images/profile.png",
        color: const Color.fromARGB(255, 3, 175, 248),
      ),
    ),
  )
];
