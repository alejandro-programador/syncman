import 'package:syncman_new/models/cursor_model.dart';

abstract class CursorRepository {
  Future<void> save(Cursor cursor);
  Future<Cursor?> getByName(String name);
}
