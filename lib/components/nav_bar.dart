import 'package:flutter/material.dart';
import 'package:wetube/screens/add_video_screen.dart';
import 'package:wetube/screens/profile_screen.dart';

class NavBar extends StatelessWidget {
  final Color color;
  final dynamic bgColor;

  const NavBar({
    super.key,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: BottomNavigationBar(
          currentIndex: 0,
          fixedColor: Colors.purple[100],
          backgroundColor: bgColor,
          unselectedItemColor: color,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Padding(
                padding:
                    EdgeInsets.only(top: 5.0), // Adjust this value as needed
                child: Icon(Icons.add_circle_outline_sharp, size: 35.0),
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.account_circle),
            ),
          ],
          onTap: (int indexOfItem) {
            if (indexOfItem == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddVideoScreen()),
              );
            } else if (indexOfItem == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            }
          }),
    );
  }
}
