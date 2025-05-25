import 'package:syncman_new/models/cursor_model.dart';
import 'package:syncman_new/repositories/cursor/cursor_repository.dart';

class MemoryCursorRepository extends CursorRepository {
  final Map<String, dynamic> _storage = {};

  @override
  Future<void> save(Cursor cursor) async {
    _storage[cursor.name] = cursor.value;
  }

  @override
  Future<Cursor?> getByName(String name) async {
    final value = _storage[name];
    if (value == null) {
      return null;
    }
    return Cursor(name: name, value: value);
  }
}
