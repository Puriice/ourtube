import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:wetube/database/service/vdo_service.dart';
import 'package:wetube/model/video.dart';
import 'package:wetube/providers/video_provider.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();

  final List<String> _types = ['Music', 'News', 'Animal', 'Gaming', 'Sport'];

  String _source = 'youtube';
  String _type = 'Music';
  XFile? _pickedFile;
  bool _isUploading = false;

  @override
  void dispose() {
    _urlController.dispose();
    _titleController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file == null) return;
    setState(() => _pickedFile = file);
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = twoDigits(d.inSeconds % 60);
    if (d.inHours > 0) {
      return '${d.inHours}:${twoDigits(d.inMinutes % 60)}:$seconds';
    }
    return '${d.inMinutes}:$seconds';
  }

  // The picker returns a file in the cache folder, which Android may clear,
  // so copy it into the app's documents folder.
  Future<String> _copyToAppFolder(XFile file) async {
    final docs = await getApplicationDocumentsDirectory();
    final videoDir = io.Directory(path.join(docs.path, 'videos'));
    await videoDir.create(recursive: true);
    final newPath = path.join(videoDir.path,
        '${DateTime.now().millisecondsSinceEpoch}${path.extension(file.path)}');
    await io.File(file.path).copy(newPath);
    return newPath;
  }

  Future<String> _readDuration(String filePath) async {
    final controller = VideoPlayerController.file(io.File(filePath));
    try {
      await controller.initialize();
      return _formatDuration(controller.value.duration);
    } finally {
      await controller.dispose();
    }
  }

  Future<void> _upload() async {
    if (!_formKey.currentState!.validate()) return;
    if (_source == 'local' && _pickedFile == null) {
      _showMessage('Please choose a video first.');
      return;
    }

    setState(() => _isUploading = true);
    // Uploaded videos always belong to the user's own profile.
    final me = context.read<VideoProvider>().me;
    try {
      Video video;
      if (_source == 'youtube') {
        final videoId = _youtubeId(_urlController.text)!;
        video = Video(
          id: videoId,
          author: me,
          title: _titleController.text.trim(),
          thumbnailUrl: 'https://i.ytimg.com/vi/$videoId/hqdefault.jpg',
          type: _type,
          duration: _durationController.text.trim().isEmpty
              ? '-'
              : _durationController.text.trim(),
          timestamp: DateTime.now(),
          viewCount: 0,
          likes: 0,
          dislikes: '0',
        );
      } else {
        final localPath = await _copyToAppFolder(_pickedFile!);
        video = Video(
          id: 'local_${DateTime.now().millisecondsSinceEpoch}',
          author: me,
          title: _titleController.text.trim(),
          thumbnailUrl: '',
          type: _type,
          duration: await _readDuration(localPath),
          timestamp: DateTime.now(),
          viewCount: 0,
          likes: 0,
          dislikes: '0',
          source: 'local',
          localPath: localPath,
        );
      }

      final inserted = await insertVideo(video);
      if (!mounted) return;
      if (!inserted) {
        _showAlert(context);
        return;
      }
      await context.read<VideoProvider>().loadVideos();
      if (!mounted) return;
      _showMessage('Video uploaded.');
      Navigator.pop(context);
    } catch (e) {
      _showMessage('Upload failed: $e');
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  // Accepts a full YouTube URL or a bare 11-character video id.
  String? _youtubeId(String input) {
    final text = input.trim();
    if (RegExp(r'^[A-Za-z0-9_-]{11}$').hasMatch(text)) return text;
    return YoutubePlayer.convertUrlToId(text);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
        ),
        title: Text(
          'Upload Video',
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'youtube',
                  label: Text('YouTube link'),
                  icon: Icon(Icons.link),
                ),
                ButtonSegment(
                  value: 'local',
                  label: Text('From phone'),
                  icon: Icon(Icons.phone_android),
                ),
              ],
              selected: {_source},
              onSelectionChanged: (selection) {
                setState(() => _source = selection.first);
              },
            ),
            const SizedBox(height: 20),
            if (_source == 'youtube') ...[
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'YouTube URL',
                  hintText: 'https://www.youtube.com/watch?v=...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (_youtubeId(value ?? '') == null) {
                    return 'Please enter a valid YouTube link.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration (optional)',
                  hintText: 'e.g. 3:45',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isNotEmpty &&
                      !RegExp(r'^\d{1,2}(:\d{2}){1,2}$').hasMatch(text)) {
                    return 'Use the format m:ss or h:mm:ss.';
                  }
                  return null;
                },
              ),
            ] else ...[
              OutlinedButton.icon(
                onPressed: _isUploading ? null : _pickVideo,
                icon: const Icon(Icons.video_library),
                label: Text(_pickedFile == null
                    ? 'Choose video from phone'
                    : 'Change video'),
              ),
              if (_pickedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Selected: ${_pickedFile!.name}',
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: _types
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) => setState(() => _type = value!),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isUploading ? null : _upload,
              icon: _isUploading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.cloud_upload),
              label: Text(_isUploading ? 'Uploading...' : 'Upload'),
            ),
          ],
        ),
      ),
    );
  }
}

void _showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text('This video has already been uploaded.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
