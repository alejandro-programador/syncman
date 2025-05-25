import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/return_record_model.dart';
import 'package:syncman_new/repositories/return-record/return_record_read_repository.dart';

class ApiReturnRecordReadRepository extends ReturnRecordReadRepository {
  final ApiService _apiService;

  ApiReturnRecordReadRepository(this._apiService);

  @override
  Future<List<ReturnRecord>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await _apiService.getRequestNew(
      '/solicitud-devolucion',
      params: {
        'size': 500,
        if (updatedAt != null) 'updatedAt': updatedAt,
        if (page != null) 'page': page,
      },
    );

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((record) {
      record['id'] = record['_id'];
      return ReturnRecord.fromJson(record);
    }).toList();
  }

  @override
  Future<ReturnRecord?> getById(String id) async {
    final response = await _apiService.getRequestNew('/solicitud-devolucion/$id');
    final data = response?.data;

    if (data == null) {
      return null;
    }

    data['id'] = data['_id'];
    return ReturnRecord.fromJson(data);
  }

  @override
  Future<ReturnRecord?> getByCodigo(String codigo) async {
    final response = await _apiService.getRequestNew(
      '/solicitud-devolucion/codigo/$codigo',
    );
    final data = response?.data;

    if (data == null) {
      return null;
    }

    data['id'] = data['_id'];
    return ReturnRecord.fromJson(data);
  }
} 