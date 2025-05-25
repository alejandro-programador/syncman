import 'dart:async';

import 'package:syncman_new/models/cursor_model.dart';
import 'package:syncman_new/repositories/cursor/cursor_repository.dart';

class CursorManager<T extends List> {
  final String _cursorName;
  final CursorRepository _cursorRepository;
  Cursor? _cursor;
  final Future<T> Function(Cursor cursor, void Function(Map<String, dynamic> newValue) setCursor)
      onNext;

  CursorManager(this._cursorName, this._cursorRepository, this.onNext);

  Future<void> init() async {
    _cursor = await _cursorRepository.getByName(_cursorName);
    if (_cursor == null) {
      _cursor = Cursor(name: _cursorName, value: {});
      await _cursorRepository.save(_cursor!);
    }
  }

  void setCursor(Map<String, dynamic> value) {
    if (_cursor == null) {
      throw Exception('Cursor not initialized');
    }
    _cursor!.value = value;
  }

  Stream<T> next() async* {
    if (_cursor == null) {
      throw Exception('Cursor not initialized');
    }

    while (true) {
      final cursor = _cursor!;
      final data = await onNext(cursor, (Map<String, dynamic> newValue) async {
        setCursor(newValue);
        await _cursorRepository.save(cursor);
      });

      yield data;

      if (data.isEmpty) {
        break;
      }
    }
  }

  Future<void> nextAll() async {
    final iterator = StreamIterator(next());
    while (await iterator.moveNext()) {}
  }

  Future<void> reset() async {
    _cursor = Cursor(name: _cursorName, value: {});
    await _cursorRepository.save(_cursor!);
  }
}
