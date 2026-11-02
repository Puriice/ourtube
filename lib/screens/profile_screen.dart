import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:wetube/components/card.dart';
import 'package:wetube/components/user_avatar.dart';
import 'package:wetube/model/video.dart';
import 'package:wetube/providers/video_provider.dart';
import 'package:wetube/screens/video_play_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Copy the picked image into the app folder so it isn't lost when the
  // picker's cache is cleared.
  Future<void> _changeAvatar(BuildContext context) async {
    final provider = context.read<VideoProvider>();
    final file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 512);
    if (file == null) return;

    final docs = await getApplicationDocumentsDirectory();
    final imageDir = io.Directory(path.join(docs.path, 'images'));
    await imageDir.create(recursive: true);
    final newPath = path.join(imageDir.path,
        'avatar_${DateTime.now().millisecondsSinceEpoch}${path.extension(file.path)}');
    await io.File(file.path).copy(newPath);

    final oldPath = provider.me.profileImagePath;
    await provider.updateProfile(provider.me.username, newPath);
    if (oldPath != null && await io.File(oldPath).exists()) {
      await io.File(oldPath).delete();
    }
  }

  Future<void> _editName(BuildContext context) async {
    final provider = context.read<VideoProvider>();
    final controller = TextEditingController(text: provider.me.username);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit name'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (newName == null || newName.isEmpty) return;
    await provider.updateProfile(newName, provider.me.profileImagePath);
  }

  Future<void> _confirmDelete(BuildContext context, Video video) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete video?'),
        content: Text('"${video.title}" will be removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<VideoProvider>().removeVideo(video);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: textColor),
        ),
        title: Text('Profile', style: TextStyle(color: textColor)),
      ),
      body: Consumer<VideoProvider>(
        builder: (context, provider, child) {
          final me = provider.me;
          final myVideos = provider.myVideos;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => _changeAvatar(context),
                  child: Stack(
                    children: [
                      UserAvatar(user: me, size: 100),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.purple,
                          child: Icon(Icons.camera_alt,
                              size: 18, color: textColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      me.username,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    tooltip: 'Edit name',
                    onPressed: () => _editName(context),
                  ),
                ],
              ),
              Text(
                '${myVideos.length} ${myVideos.length == 1 ? 'video' : 'videos'}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
              const Divider(height: 32),
              const Text(
                'My videos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (myVideos.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Text(
                    "You haven't uploaded any videos yet. Tap + to upload.",
                    textAlign: TextAlign.center,
                  ),
                )
              else ...[
                Text(
                  'Long-press a video to delete it.',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                const SizedBox(height: 8),
                for (final video in myVideos)
                  Container(
                    margin: const EdgeInsets.only(bottom: 4.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VideoPlayScreen(video: video)),
                      ),
                      onLongPress: () => _confirmDelete(context, video),
                      child: VideoCard(video: video),
                    ),
                  ),
              ],
            ],
          );
        },
      ),
    );
  }
}
