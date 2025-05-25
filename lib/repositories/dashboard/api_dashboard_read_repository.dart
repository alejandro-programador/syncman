import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/dashboard_model.dart';
import 'package:syncman_new/repositories/dashboard/dashboard_read_repository.dart';

class ApiDashboardReadRepository implements DashboardReadRepository {
  final ApiService _apiService;

  ApiDashboardReadRepository(this._apiService);

  @override
  Future<Dashboard> query({
    String? updatedAt,
    int? page,
  }) async {
    try {
      final response = await _apiService.getRequestNew('/dashboard');
      if (response?.data != null) {
        return Dashboard.fromMap(response!.data);
      }
      return Dashboard.emptyDashboard;
    } catch (e) {
      return Dashboard.emptyDashboard;
    }
  }
}