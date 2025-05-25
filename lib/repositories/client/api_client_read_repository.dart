import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/repositories/client/client_read_repository.dart';

class ApiClientReadRepository extends ClientReadRepository {
  final ApiService _api;

  ApiClientReadRepository(this._api);

  @override
  Future<List<Client>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/clientes', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((client) {
      client['id'] = client['_id'];
      return Client.fromMap(client);
    }).toList();
  }

  @override
  Future<Client?> getById(String id) async {
    final response = await _api.getRequestNew('/clientes/$id');
    final data = response?.data;

    if (data) {
      return Client.fromMap(data);
    }

    return null;
  }

  @override
  Future<Client?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/clientes/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Client.fromMap(data);
    }

    return null;
  }
}
