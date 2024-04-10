import 'package:flutter/material.dart';

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
    return AppBar(
      backgroundColor: bgColor,
      title: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.play_circle_fill_rounded),
                color: color,
                onPressed: () {},
              ),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
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
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                color: color,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
