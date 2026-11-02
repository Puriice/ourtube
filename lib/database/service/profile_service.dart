import 'package:wetube/database/database_connect.dart';
import 'package:wetube/model/user.dart';

// Videos uploaded by the user store this in the Video.author column, so
// renaming the profile doesn't break the link to those videos.
const String myChannelId = 'me';

const String defaultProfileName = 'My Channel';

Future<User> fetchProfile() async {
  final db = await DatabaseHelper().db;
  final rows = await db.query('Profile', where: 'id = 1');
  final row = rows.isEmpty ? null : rows.first;
  return User(
    username: (row?['username'] as String?) ?? defaultProfileName,
    profileImageUrl: '',
    subscribers: '0',
    profileImagePath: row?['imagePath'] as String?,
    isMe: true,
  );
}

Future<void> saveProfile(String username, String? imagePath) async {
  final db = await DatabaseHelper().db;
  await db.rawInsert(
    'INSERT OR REPLACE INTO Profile(id, username, imagePath) VALUES(1, ?, ?)',
    [username, imagePath],
  );
}
