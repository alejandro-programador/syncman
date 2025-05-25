import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/transport_model.dart';
import 'package:syncman_new/repositories/transport/transport_read_repository.dart';

class ApiTransportReadRepository extends TransportReadRepository {
  final ApiService _api;

  ApiTransportReadRepository(this._api);

  @override
  Future<List<Transport>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/transports', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((transport) {
      transport['id'] = transport['_id'];
      return Transport.fromJson(transport);
    }).toList();
  }

  @override
  Future<Transport?> getById(String id) async {
    final response = await _api.getRequestNew('/transports/$id');
    final data = response?.data;

    if (data) {
      return Transport.fromJson(data);
    }

    return null;
  }

  @override
  Future<Transport?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/transports/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Transport.fromJson(data);
    }

    return null;
  }
} 