import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/configuration_model.dart';
import 'package:syncman_new/repositories/configuration/configuration_read_repository.dart';

class ApiConfigurationReadRepository extends ConfigurationReadRepository {
  final ApiService _apiService;

  ApiConfigurationReadRepository(this._apiService);

  @override
  Future<Configuration?> get() async {
    final response = await _apiService.getRequestNew('/emp-configuraciones/nombre/configApp');
    final data = response?.data;

    if (data == null || data.isEmpty) {
      return null;
    }

    final configuracion = Configuration.fromJson(data);
    return configuracion;
  }
}
