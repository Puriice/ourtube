import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final Color color;
  final dynamic bgColor;

  const NavBar({
    Key? key,
    required this.color,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: 0,
        fixedColor: Colors.purple[100],
        backgroundColor: bgColor,
        unselectedItemColor: color,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle),
          ),
        ],
        onTap: (int indexOfItem) {});
  }
}
