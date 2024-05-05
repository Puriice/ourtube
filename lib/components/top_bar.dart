import 'package:flutter/material.dart';
import 'package:wetube/screens/search_screen.dart';

class FirstTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;
  final dynamic bgColor;

  const FirstTopBar(
      {required this.title,
      required this.color,
      required this.bgColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: bgColor,
      leadingWidth: 120.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Image.asset('assets/icon/logo_topbar.png'),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_alert),
          color: color,
          tooltip: 'Notifications',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search),
          color: color,
          tooltip: 'Search',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          color: color,
          tooltip: 'Settings',
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
