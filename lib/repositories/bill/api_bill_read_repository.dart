import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/repositories/bill/bill_read_repository.dart';
import 'package:dio/dio.dart';

class ApiBillReadRepository extends BillReadRepository {
  final ApiService _api;

  ApiBillReadRepository(this._api);

  @override
  Future<List<Bill>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/factura-ventas', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((bill) {
      bill['id'] = bill['_id'];
      return Bill.fromMap(bill);
    }).toList();
  }

  @override
  Future<Bill?> getById(String id) async {
    final response = await _api.getRequestNew('/factura-ventas/$id');
    final data = response?.data;

    if (data) {
      return Bill.fromMap(data);
    }

    return null;
  }

  @override
  Future<Bill?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/factura-ventas/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Bill.fromMap(data);
    }

    return null;
  }

  @override
  Future<List<Bill>> getByClientId(String clientId, {int page = 0, int pageSize = 50}) async {
    try {
      final response = await _api.getRequestNew('/factura-ventas/$clientId');

      final data = response?.data;
      if (data == null) {
        return [];
      }

      // Handle both single object and list responses
      List<dynamic> billsList;
      if (data is List) {
        billsList = data;
      } else if (data is Map) {
        billsList = [data];
      } else {
        return [];
      }

      return billsList.map((bill) {
        bill['id'] = bill['_id'];
        return Bill.fromMap(bill);
      }).toList();
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        // Si es un error 404, intentamos obtener el mensaje de error
        final errorMessage = e.response?.data?.toString() ?? 'No se encontraron facturas para este cliente';
        throw Exception(errorMessage);
      }
      rethrow;
    }
  }
} 