import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/bank_model.dart';
import 'package:syncman_new/repositories/bank/bank_read_repository.dart';

class ApiBankReadRepository extends BankReadRepository {
  final ApiService _api;

  ApiBankReadRepository(this._api);

  @override
  Future<List<Bank>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/bancos', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((bank) {
      bank['id'] = bank['_id'];
      return Bank.fromMap(bank);
    }).toList();
  }

  @override
  Future<Bank?> getById(String id) async {
    final response = await _api.getRequestNew('/bancos/$id');
    final data = response?.data;

    if (data) {
      return Bank.fromMap(data);
    }

    return null;
  }
}
