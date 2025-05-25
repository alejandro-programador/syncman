import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncman_new/models/cursor_model.dart';
import 'package:syncman_new/repositories/cursor/cursor_repository.dart';
import 'dart:convert';

class LocalCursorRepository extends CursorRepository {
  @override
  Future<void> save(Cursor cursor) async {
    final prefers = await SharedPreferences.getInstance();
    final cursorMap = cursor.toMap();

    await prefers.setString(cursor.name, jsonEncode(cursorMap));
  }

  @override
  Future<Cursor?> getByName(String name) async {
    final prefers = await SharedPreferences.getInstance();
    final cursorString = prefers.getString(name);

    if (cursorString == null) {
      return null;
    }

    final cursorMap = jsonDecode(cursorString) as Map<String, dynamic>;
    if (cursorMap.isEmpty) {
      return null;
    }

    final cursor = Cursor.fromMap(cursorMap);
    return cursor;
  }
}
