import 'package:syncman_new/models/dashboard_model.dart';
import 'package:syncman_new/repositories/dashboard/dashboard_read_repository.dart';
import 'package:syncman_new/repositories/dashboard/dashboard_write_repository.dart';

class DashboardService {
  final DashboardReadRepository _dashboardReadRepository;
  final DashboardWriteRepository _dashboardWriteRepository;

  DashboardService(this._dashboardReadRepository, this._dashboardWriteRepository);

  Future<List<Dashboard>> query({
    String? updatedAt,
    int? page,
  }) async {
    final dashboard = await _dashboardReadRepository.query(updatedAt: updatedAt, page: page);
    return [dashboard];
  }

  Future<void> updateOrCreate(Dashboard dashboard) async {
    await _dashboardWriteRepository.saveDashboard(dashboard);
  }
} 