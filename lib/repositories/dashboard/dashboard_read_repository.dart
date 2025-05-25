import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/dashboard_model.dart';

abstract class DashboardReadRepository {
  Future<Dashboard> query({
    String? updatedAt,
    int? page,
  });
}

class LocalDashboardReadRepository implements DashboardReadRepository {
  final Database _database;

  LocalDashboardReadRepository(this._database);

  @override
  Future<Dashboard> query({String? updatedAt, int? page}) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        'dashboard',
        where: updatedAt != null ? 'updated_at > ?' : null,
        whereArgs: updatedAt != null ? [updatedAt] : null,
        limit: 1,
      );

      if (maps.isEmpty) {
        return Dashboard.emptyDashboard;
      }

      return Dashboard.fromMap(maps.first);
    } catch (e) {
      print('Error querying dashboard: $e');
      return Dashboard.emptyDashboard;
    }
  }
} 