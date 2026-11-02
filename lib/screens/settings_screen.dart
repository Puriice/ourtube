import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wetube/providers/settings_provider.dart';
import 'package:wetube/providers/video_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmDeleteAll(BuildContext context) async {
    final videoProvider = context.read<VideoProvider>();
    final count = videoProvider.videos.length;
    if (count == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('There are no videos to delete.')));
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all videos?'),
        content: Text(
            '${count == 1 ? 'Your 1 video' : 'All $count videos'} will be '
            'removed. This cannot be undone.'),
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
    if (confirmed != true || !context.mounted) return;

    await videoProvider.removeAllVideos();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All videos deleted.')));
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: textColor),
        ),
        title: Text('Settings', style: TextStyle(color: textColor)),
      ),
      body: ListView(
        children: [
          _sectionTitle(context, 'Appearance'),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark mode'),
            value: settings.darkMode,
            onChanged: settings.setDarkMode,
          ),
          _sectionTitle(context, 'Playback'),
          SwitchListTile(
            secondary: const Icon(Icons.play_circle_outline),
            title: const Text('Autoplay'),
            subtitle: const Text('Start playing when you open a video'),
            value: settings.autoplay,
            onChanged: settings.setAutoplay,
          ),
          _sectionTitle(context, 'Data'),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text(
              'Delete all videos',
              style: TextStyle(color: Colors.red),
            ),
            subtitle: const Text('Removes every video from this phone'),
            onTap: () => _confirmDeleteAll(context),
          ),
          _sectionTitle(context, 'About'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('OurTube'),
            subtitle: Text('Version 0.1.0 · CP213 project'),
          ),
        ],
      ),
    );
  }
}
