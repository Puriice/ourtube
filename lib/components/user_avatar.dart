import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:wetube/model/user.dart';

// Round profile picture: a picked image file, a network URL, or an icon.
class UserAvatar extends StatelessWidget {
  final User user;
  final double size;

  const UserAvatar({super.key, required this.user, this.size = 50});

  @override
  Widget build(BuildContext context) {
    final fallback = SizedBox(
      height: size,
      width: size,
      child: Icon(Icons.account_circle, size: size),
    );

    Widget image;
    if (user.profileImagePath != null) {
      image = Image.file(
        io.File(user.profileImagePath!),
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback,
      );
    } else if (user.profileImageUrl.isNotEmpty) {
      image = Image.network(
        user.profileImageUrl,
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback,
      );
    } else {
      return fallback;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: image,
    );
  }
}
