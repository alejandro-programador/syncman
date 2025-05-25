import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/tax_model.dart';
import 'package:syncman_new/repositories/tax/tax_read_repository.dart';

class ApiTaxReadRepository extends TaxReadRepository {
  final ApiService _api;

  ApiTaxReadRepository(this._api);

  @override
  Future<List<Tax>> getAllTaxes() async {
    final response = await ApiService().getRequestNew('/impuesto-sobre-venta-renglones', params: {
      'size': 500,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((tax) {
      tax['id'] = tax['_id'];
      return Tax.fromJson(tax);
    }).toList();
  }

  @override
  Future<Tax?> getTaxById(String id) async {
    final response = await _api.getRequestNew('/impuesto-sobre-venta-renglones/$id');
    final data = response?.data;

    if (data) {
      return Tax.fromJson(data);
    }

    return null;
  }

  @override
  Future<List<Tax>> getTaxesByDate(String date) async {
    final response = await ApiService().getRequestNew('/impuesto-sobre-venta-renglones/date/$date');
    final data = response?.data;

    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((tax) {
      tax['id'] = tax['_id'];
      return Tax.fromJson(tax);
    }).toList();
  }
} 