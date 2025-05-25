import 'package:syncman_new/models/bank_model.dart';

abstract class BankReadRepository {
  Future<List<Bank>> query({
    String? updatedAt,
    int? page,
  });

  Future<Bank?> getById(String id);
}
